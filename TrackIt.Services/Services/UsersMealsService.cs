using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class UsersMealsService : BaseCRUDService<Model.Models.UsersMeal, Database.UsersMeal, UsersMealsSearchObject, UsersMealsInsertRequest, UsersMealsUpdateRequest>, IUsersMealsService
	{
		IDailyIntakeService _dailyIntakeService;
		public UsersMealsService(TrackItContext context, IMapper mapper, IDailyIntakeService dailyIntakeService) : base(context, mapper)
		{
			_dailyIntakeService = dailyIntakeService;
		}

		public override IQueryable<UsersMeal> AddFilter(IQueryable<UsersMeal> query, UsersMealsSearchObject? search = null)
		{
			if (search?.MealId > 0)
			{
				query = query.Where(um => um.MealId == search.MealId);
			}
			if (search?.UserId > 0)
			{
				query = query.Where(um => um.UserId == search.UserId);
			}
			query = query.Where(um => um.DateConsumed.Value.Date == search.Date.Date);
			return base.AddFilter(query, search);
		}

		public override IQueryable<UsersMeal> AddInclude(IQueryable<UsersMeal> query, UsersMealsSearchObject? search = null)
		{
			if (search?.isMealIncluded == true)
			{
				query = query.Include("Meal");
			}
			if (search?.isUserIncluded == true)
			{
				query = query.Include("User");
			}
			return base.AddInclude(query, search);
		}

		public override Task<Model.Models.UsersMeal> Insert(UsersMealsInsertRequest insert)
		{
			// before inserting a record of UsersMeals the users DailyIntake for today should be created/updated
			var meal = _context.Meals.FirstOrDefault(m => m.MealId == insert.MealId);
			_dailyIntakeService.UpdateOnLogging(insert.UserId, meal, insert.Servings);

			return base.Insert(insert);
		}

		public async Task<List<Model.Models.Meal>> MostPopularMeals()
		{
			var topThreeMeals = _context.UsersMeals.GroupBy(um => um.MealId)
				.Select(group => new { MealId = group.Key, Count = group.Count() })
				.OrderByDescending(meal => meal.Count).Take(3).ToList();

			var meals = new List<Meal>();
			var mealSet = _context.Set<Meal>();
			foreach (var topMeal in topThreeMeals)
			{
				var foundMeal = await mealSet.Where(meal => meal.MealId == topMeal.MealId).FirstOrDefaultAsync();
				if (foundMeal != null)
				{
					meals.Add(foundMeal);
				}
			}
			return _mapper.Map<List<Model.Models.Meal>>(meals);
		}
	}
}
