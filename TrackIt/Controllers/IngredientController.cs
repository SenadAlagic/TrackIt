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
	public class IngredientController : BaseCRUDController<Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>, IReportable
	{
		IIngredientService _service;
		public IngredientController(ILogger<BaseController<Ingredient, IngredientSearchObject>> logger, IIngredientService service) : base(logger, service)
		{
			_service = service;
		}

		[Authorize(Roles = "admin")]
		public override Task<Ingredient> Insert([FromBody] IngredientInsertRequest insert)
		{
			return base.Insert(insert);
		}

		[Authorize(Roles = "admin")]
		public override Task<Ingredient> Update(int id, [FromBody] IngredientUpdateRequest update)
		{
			return base.Update(id, update);
		}

		[AllowAnonymous]
		public override Task<PagedResult<Ingredient>> Get([FromQuery] IngredientSearchObject search)
		{
			return base.Get(search);
		}

		[Authorize(Roles = "admin")]
		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}