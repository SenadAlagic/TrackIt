using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class ActivityLevelController : BaseCRUDController<ActivityLevel, ActivityLevelSearchObject, ActivityLevelInsertRequest, ActivityLevelUpdateRequest>
	{
		public ActivityLevelController(ILogger<BaseController<ActivityLevel, ActivityLevelSearchObject>> logger, IActivityLevelService service) : base(logger, service)
		{
		}
	}
}