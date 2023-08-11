using TrackIt.Model.Models;
using TrackIt.Model.Requests;

namespace TrackIt.Services.Interfaces
{
    public interface IUserService
	{
		List<User> Get();
		User Update(int id, UserUpdateRequest request);
	}
}
