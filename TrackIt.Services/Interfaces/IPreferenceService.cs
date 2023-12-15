using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IPreferenceService : ICRUDService<Preference, PreferenceSearchObject, PreferenceInsertRequest, PreferenceUpdateRequest>
	{
	}
}
