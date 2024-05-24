using Microsoft.AspNetCore.Mvc;
using TrackIt.Interfaces;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class GoalController : BaseCRUDController<Goal, GoalSearchObject, GoalInsertRequest, GoalUpdateRequest>, IReportable
	{
		IGoalService _service;
		public GoalController(ILogger<BaseController<Goal, GoalSearchObject>> logger, IGoalService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}