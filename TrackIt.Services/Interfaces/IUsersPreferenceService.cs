using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IUsersPreferenceService : ICRUDService<UsersPreference, UsersPreferencesSearchObject, UsersPreferencesInsertRequest, UsersPreferencesUpdateRequest>
	{
	}
}
