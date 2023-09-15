using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IGeneralUserService : ICRUDService<GeneralUser, GeneralUserSearchObject, GeneralUserInsertRequest, GeneralUserUpdateRequest>
	{
		Task<GeneralUser> UpdateBaseUser(int id, UserUpdateRequest update);
	}
}
