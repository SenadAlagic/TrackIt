using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class MealController : BaseCRUDController<Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>
	{
		public MealController(ILogger<BaseController<Meal, MealSearchObject>> logger, IMealsService service) : base(logger, service)
		{
		}
	}
}