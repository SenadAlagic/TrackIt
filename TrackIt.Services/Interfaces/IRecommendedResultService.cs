using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IRecommendedResultService : ICRUDService<RecommendedResult, RecommendedResultSearchObject, RecommendedResultInsertRequest, RecommendedResultUpdateRequest>
	{
		void TrainModel();
		Task<Meal> Recommend(int mealId);
		Task DeleteAllRecommendation();
	}
}
