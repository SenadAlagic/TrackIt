using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Helper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class MealsService : BaseCRUDService<Model.Models.Meal, Database.Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>, IMealsService
	{
		private IMealsIngredientsService _mealsIngredientsService;
		private readonly TrackItContext context;
		public MealsService(TrackItContext context, IMapper mapper, IMealsIngredientsService mealsIngredientsService) : base(context, mapper)
		{
			this.context = context;
			_mealsIngredientsService = mealsIngredientsService;
		}

		public override IQueryable<Meal> AddInclude(IQueryable<Meal> query, MealSearchObject? search = null)
		{
			if (search?.IsIngredientsIncluded == true)
			{
				query = query.Include("MealsIngredients.Ingredient");
			}
			if (search?.IsTagsIncluded == true)
			{
				query = query.Include("TagsMeals.Tag");
			}
			return base.AddInclude(query, search);
		}

		public override IQueryable<Meal> AddFilter(IQueryable<Meal> query, MealSearchObject? search = null)
		{
			if (search?.IngredientIds?.Length > 0)
			{
				var mealIngredientsCount = context.MealsIngredients
				.Where(mi => search.IngredientIds.Contains(mi.IngredientId));

				var groupedUp = mealIngredientsCount.GroupBy(mi => mi.MealId);
				var mealsMatchingCondition = groupedUp
				.Where(group => group.Select(mi => mi.IngredientId).Distinct().Count() == search.IngredientIds.Length)
				.Select(group => group.Key);

				query = context.Meals
					.Where(meal => mealsMatchingCondition.Contains(meal.MealId));
			}
			if (search.Preferences?.Length > 0)
			{
				var preferences = search.Preferences;
				foreach (var preference in preferences)
				{
					query = query.Where(m => m.TagsMeals.Any(t => t.Tag.Name == preference));
				}
			}
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(meal => meal.Name.ToLower().Contains(search.Name.ToLower()));
			}
			return base.AddFilter(query, search);
		}

		public async Task<Model.Models.Meal> SetIngredients(int mealId, IngredientData[] ingredientData)
		{
			var set = _context.Set<Meal>();
			var mealsIngredientsSet = _context.Set<MealsIngredient>();
			var ingredientsSet = _context.Set<Ingredient>();

			var existingConnections = mealsIngredientsSet.Where(mi => mi.MealId == mealId).ToList();
			foreach (var connection in existingConnections)
			{
				mealsIngredientsSet.Remove(connection);
			}

			var entity = await set.Include(m => m.MealsIngredients).ThenInclude(mi => mi.Ingredient).FirstOrDefaultAsync(m => m.MealId == mealId);
			if (entity != null)
			{
				entity.Fat = 0;
				entity.Calories = 0;
				entity.Carbs = 0;
				entity.Protein = 0;
			}

			foreach (var data in ingredientData)
			{
				var ingredient = ingredientsSet.Where(i => i.IngredientId == data.IngredientId).FirstOrDefault();
				if (ingredient == null) continue;
				var insert = new MealsIngredientsInsertRequest() { MealId = mealId, IngredientId = ingredient.IngredientId, IngredientQuantity = data.Quantity };
				await _mealsIngredientsService.Insert(insert);

				//var newConnection = new MealsIngredient() { IngredientId = data.IngredientId, MealId = mealId, IngredientQuantity = data.Quantity };
				//mealsIngredientsSet.Add(newConnection);
			}

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.Meal>(entity);
		}

		public async Task<int> GetNumberOfItems()
		{
			return await _context.Meals.CountAsync();
		}
	}
}
