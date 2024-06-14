using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Helper;
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

		[AllowAnonymous]
		public override Task<PagedResult<ActivityLevel>> Get([FromQuery] ActivityLevelSearchObject search)
		{
			return base.Get(search);
		}
	}
}