using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IIngredientService : ICRUDService<Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>
	{
	}
}
