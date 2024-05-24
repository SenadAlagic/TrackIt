using Microsoft.AspNetCore.Mvc;
using TrackIt.Interfaces;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class IngredientController : BaseCRUDController<Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>, IReportable
	{
		IIngredientService _service;
		public IngredientController(ILogger<BaseController<Ingredient, IngredientSearchObject>> logger, IIngredientService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}