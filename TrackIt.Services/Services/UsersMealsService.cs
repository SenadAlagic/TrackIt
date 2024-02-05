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
	}
}
