using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Helper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class UsersMealsService : BaseCRUDService<Model.Models.UsersMeal, Database.UsersMeal, UsersMealsSearchObject, UsersMealsInsertRequest, UsersMealsUpdateRequest>, IUsersMealsService
	{
		public UsersMealsService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
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

		public async Task<PagedResult<Model.Models.Meal>> GetTodaysMeals(int userId)
		{
			var todaysMeals = await _context.UsersMeals.Where(um => um.UserId == userId && um.DateConsumed.Value.Date == DateTime.Today).Select(um => um.Meal).ToListAsync();

			var pagedResult = new PagedResult<Model.Models.Meal>();
			var tmp = _mapper.Map<List<Model.Models.Meal>>(todaysMeals);
			pagedResult.Result = tmp;

			return pagedResult;
		}
	}
}
