using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IActivityLevelService : ICRUDService<Model.Models.ActivityLevel, ActivityLevelSearchObject, ActivityLevelInsertRequest, ActivityLevelUpdateRequest>
	{
	}
}
