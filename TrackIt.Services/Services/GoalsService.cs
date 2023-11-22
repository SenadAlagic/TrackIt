using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class GoalsService : BaseCRUDService<Model.Models.Goal, Database.Goal, GoalSearchObject, GoalInsertRequest, GoalUpdateRequest>, IGoalService
	{
		public GoalsService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override IQueryable<Goal> AddFilter(IQueryable<Goal> query, GoalSearchObject? search = null)
		{
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(goal => goal.Name.ToLower().Contains(search.Name.ToLower()));
			}
			if (search?.Description.IsNullOrEmpty() == false)
			{
				query = query.Where(goal => goal.Description.ToLower().Contains(search.Description.ToLower()));
			}
			return base.AddFilter(query, search);
		}
	}
}
