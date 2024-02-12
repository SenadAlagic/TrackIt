using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class WeightOverTimeController : BaseController<WeightOverTime, WeightOverTimeSearchObject>
	{
		public WeightOverTimeController(ILogger<BaseController<WeightOverTime, WeightOverTimeSearchObject>> logger, IWeightOverTimeService service) : base(logger, service)
		{
		}
	}
}