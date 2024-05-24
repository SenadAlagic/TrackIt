using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IMealsService : ICRUDService<Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>
	{
		Task<Meal> SetIngredients(int id, IngredientData[] ingredientIds);
		Task<int> GetNumberOfItems();

	}
}
