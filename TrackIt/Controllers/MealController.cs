using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class MealController : BaseController<Model.Meal, MealSearchObject>
	{
		public MealController(ILogger<BaseController<Model.Meal, MealSearchObject>> logger, IMealsService service) : base(logger, service)
		{

		}
	}
}