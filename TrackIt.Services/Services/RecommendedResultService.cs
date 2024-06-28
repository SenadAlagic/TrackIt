using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class RecommendedResultService : BaseCRUDService<Model.Models.RecommendedResult, Database.RecommendedResult, RecommendedResultSearchObject, RecommendedResultInsertRequest, RecommendedResultUpdateRequest>, IRecommendedResultService
	{
		public RecommendedResultService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{

		}
		static MLContext _mlContext = null;
		static object isLocked = new object();
		static ITransformer modeltr = null;

		public void TrainModel()
		{
			lock (isLocked)
			{
				if (_mlContext == null)
				{
					_mlContext = new MLContext();
					var tmpData = _context.UsersMeals.ToList().GroupBy(um => um.DateConsumed);
					var data = new List<MealEntry>();

					var coOccurrences = _context.UsersMeals.ToList().GroupBy(um => new { um.UserId, um.DateConsumed });
					foreach (var item in coOccurrences)
					{
						foreach (var meal in item)
						{
							var relatedItems = item.Where(i => i.MealId != meal.MealId);
							foreach (var relatedItem in relatedItems)
							{
								data.Add(new MealEntry { MealID = (uint)meal.MealId, CoMealID = (uint)relatedItem.MealId });
							}
						}
					}

					var trainData = _mlContext.Data.LoadFromEnumerable(data);
					MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
					options.MatrixColumnIndexColumnName = nameof(MealEntry.MealID);
					options.MatrixRowIndexColumnName = nameof(MealEntry.CoMealID);
					options.LabelColumnName = "Label";
					options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
					options.Alpha = 0.01;
					options.Lambda = 0.025;
					options.NumberOfIterations = 100;
					options.C = 0.00001;

					var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);

					modeltr = est.Fit(trainData);
				}
			}
		}

		public async Task<Model.Models.Meal> Recommend(int mealId)
		{
			if (modeltr == null)
				return null;

			var alreadyPredictedResult = await _context.RecommendedResults.Where(rr => rr.MealId == mealId).FirstOrDefaultAsync();
			if (alreadyPredictedResult != null)
			{
				var mealToReturn = await _context.Meals.Include(m => m.MealsIngredients).ThenInclude(mi => mi.Ingredient).FirstOrDefaultAsync(m => m.MealId == alreadyPredictedResult.MealId);
				return _mapper.Map<Model.Models.Meal>(mealToReturn);
			}

			var meals = _context.Meals.Where(m => m.MealId != mealId).Include(m => m.MealsIngredients).ThenInclude(mi => mi.Ingredient);
			var predictionResult = new List<Tuple<Meal, float>>();

			foreach (var meal in meals)
			{
				var predictionEngine = _mlContext.Model.CreatePredictionEngine<MealEntry, CoMealPrediction>(modeltr);
				var prediction = predictionEngine.Predict(new MealEntry() { MealID = (uint)mealId, CoMealID = (uint)meal.MealId });
				predictionResult.Add(new Tuple<Meal, float>(meal, prediction.Score));
			}

			var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).FirstOrDefault();

			_context.RecommendedResults.Add(new RecommendedResult() { MealId = mealId, RecommendedMealId = finalResult.MealId });
			await _context.SaveChangesAsync();

			if (finalResult != null)
				return _mapper.Map<Model.Models.Meal>(finalResult);
			return null;
		}

		public Task DeleteAllRecommendation()
		{
			return _context.RecommendedResults.ExecuteDeleteAsync();
		}

		public class MealEntry
		{
			[KeyType(count: 1000)]
			public uint MealID { get; set; }

			[KeyType(count: 1000)]
			public uint CoMealID { get; set; }

			public float Label { get; set; }
		}

		public class CoMealPrediction
		{
			public float Score { get; set; }
		}
	}
}
