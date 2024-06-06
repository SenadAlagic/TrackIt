using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IUserService : ICRUDService<User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
	{
		List<User> Get();
		User Update(int id, UserUpdateRequest request);
		Task<AuthResponse> AuthenticateUser(string email, string password, string role);
	}
}
