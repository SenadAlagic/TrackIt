using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class MealController : BaseCRUDController<Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>
	{
		IMealsService _service;
		public MealController(ILogger<BaseController<Meal, MealSearchObject>> logger, IMealsService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpPut("/addIngredients/{mealId}")]
		public virtual async Task<Meal> AddIngredients(int mealId, [FromBody] IngredientData[] ingredientData)
		{
			return await _service.AddIngredients(mealId, ingredientData);
		}

		[HttpPut("/removeIngredients/{mealId}")]
		public virtual async Task<Meal> RemoveIngredients(int mealId, [FromQuery] int[] ingredientIds)
		{
			return await _service.RemoveIngredients(mealId, ingredientIds);
		}
	}
}