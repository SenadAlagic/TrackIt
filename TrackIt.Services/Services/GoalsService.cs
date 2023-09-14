using AutoMapper;
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
	}
}
