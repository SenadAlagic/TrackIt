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

		[HttpPut("/setIngredients/{mealId}")]
		public virtual async Task<Meal> SetIngredients(int mealId, [FromBody] IngredientData[] ingredientData)
		{
			return await _service.SetIngredients(mealId, ingredientData);
		}

		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}