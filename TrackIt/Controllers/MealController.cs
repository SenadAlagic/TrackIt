using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TrackIt.Interfaces;
using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class MealController : BaseCRUDController<Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>, IReportable
	{
		IMealsService _service;
		public MealController(ILogger<BaseController<Meal, MealSearchObject>> logger, IMealsService service) : base(logger, service)
		{
			_service = service;
		}

		[Authorize(Roles = "admin")]
		public override Task<Meal> Insert([FromBody] MealInsertRequest insert)
		{
			return base.Insert(insert);
		}

		[Authorize(Roles = "admin")]
		public override Task<Meal> Update(int id, [FromBody] MealUpdateRequest update)
		{
			return base.Update(id, update);
		}

		[AllowAnonymous]
		public override Task<PagedResult<Meal>> Get([FromQuery] MealSearchObject search)
		{
			return base.Get(search);
		}

		[HttpPut("/setIngredients/{mealId}")]
		public virtual async Task<Meal> SetIngredients(int mealId, [FromBody] IngredientData[] ingredientData)
		{
			return await _service.SetIngredients(mealId, ingredientData);
		}

		[Authorize(Roles = "admin")]
		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}