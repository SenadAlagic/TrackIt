using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IGoalService : ICRUDService<Goal, GoalSearchObject, GoalInsertRequest, GoalUpdateRequest>
	{
		Task<int> GetNumberOfItems();
	}
}
