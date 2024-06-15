using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Helper;
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

		[HttpGet("/getTodaysMeals")]
		public async Task<PagedResult<Meal>> GetTodaysMeals([FromQuery] int userId)
		{
			return await _service.GetTodaysMeals(userId);
		}
	}
}