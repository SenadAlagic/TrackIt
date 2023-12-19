using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
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
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(meal => meal.Name.ToLower().Contains(search.Name.ToLower()));
			}
			return base.AddFilter(query, search);
		}

		public async Task<Model.Models.Meal> AddIngredients(int id, int[] preferenceIds)
		{
			var set = _context.Set<Meal>();
			var ingredientsSet = _context.Set<Ingredient>();

			foreach (var ingredient in ingredientsSet)
			{
				var insert = new MealsIngredientsInsertRequest() { MealId = id, IngredientId = ingredient.IngredientId };
				await _mealsIngredientsService.Insert(insert);
			}

			var entity = await set.Include(m => m.MealsIngredients).ThenInclude(mi => mi.Ingredient).FirstOrDefaultAsync(m => m.MealId == id);

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.Meal>(entity);
		}

		public async Task<Model.Models.Meal> RemoveIngredients(int id, int[] ingredientIds)
		{
			var set = _context.Set<Meal>();
			foreach (var ingredient in ingredientIds)
			{
				await _mealsIngredientsService.Remove(ingredient);
			}

			var entity = await set.Include(m => m.MealsIngredients).ThenInclude(mi => mi.Ingredient).FirstOrDefaultAsync(m => m.MealId == id);

			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.Meal>(entity);
		}
	}
}
