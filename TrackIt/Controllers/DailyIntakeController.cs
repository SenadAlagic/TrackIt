using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class DailyIntakeController : BaseCRUDController<DailyIntake, DailyIntakeSearchObject, DailyIntakeInsertRequest, DailyIntakeUpdateRequest>
	{
		public DailyIntakeController(ILogger<BaseController<DailyIntake, DailyIntakeSearchObject>> logger, IDailyIntakeService service) : base(logger, service)
		{
		}
	}
}