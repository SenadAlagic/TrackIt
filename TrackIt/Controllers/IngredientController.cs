using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class IngredientController : BaseCRUDController<Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>
	{
		public IngredientController(ILogger<BaseController<Ingredient, IngredientSearchObject>> logger, IIngredientService service) : base(logger, service)
		{
		}
	}
}