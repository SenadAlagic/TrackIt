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
		private readonly TrackItContext context;
		public MealsService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
			this.context = context;
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
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(meal => meal.Name.ToLower().Contains(search.Name.ToLower()));
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
			return base.AddFilter(query, search);
		}
	}
}
