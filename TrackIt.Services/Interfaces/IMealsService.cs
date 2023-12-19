using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IMealsService : ICRUDService<Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>
	{
		Task<Meal> AddIngredients(int id, int[] ingredients);
		Task<Meal> RemoveIngredients(int id, int[] ingredientIds);
	}
}
