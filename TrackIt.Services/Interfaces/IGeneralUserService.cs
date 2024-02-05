using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IGeneralUserService : ICRUDService<GeneralUser, GeneralUserSearchObject, GeneralUserInsertRequest, GeneralUserUpdateRequest>
	{
		Task<GeneralUser> UpdateBaseUser(int id, UserUpdateRequest update);
		Task<GeneralUser> SelectActivityLevel(int id, int activityLevelId);
		Task<GeneralUser> SelectGoal(int id, int goalId);
		Task<GeneralUser> AddPreferences(int id, int[] preferenceIds);
		Task<GeneralUser> RemovePreferences(int id, int[] preferenceIds);
	}
}
