using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IMealsService : ICRUDService<Model.Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>
	{
	}
}
