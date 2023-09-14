using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class GoalController : BaseCRUDController<Goal, GoalSearchObject, GoalInsertRequest, GoalUpdateRequest>
	{
		public GoalController(ILogger<BaseController<Goal, GoalSearchObject>> logger, IGoalService service) : base(logger, service)
		{
		}
	}
}