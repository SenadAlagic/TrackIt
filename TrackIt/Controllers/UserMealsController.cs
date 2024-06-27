using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class UserMealController : BaseCRUDController<UsersMeal, UsersMealsSearchObject, UsersMealsInsertRequest, UsersMealsUpdateRequest>
	{
		IUsersMealsService _service;
		public UserMealController(ILogger<BaseController<UsersMeal, UsersMealsSearchObject>> logger, IUsersMealsService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpGet("/getMostPopularMeals")]
		public async Task<List<Meal>> GetMostPopularMeals()
		{
			return await _service.MostPopularMeals();
		}
	}
}