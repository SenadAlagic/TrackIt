using TrackIt.Model;
using TrackIt.Model.Requests;

namespace TrackIt.Services.Interfaces
{
	public interface IUserService
	{
		List<Model.User> Get();
		User Update(int id, UserUpdateRequest request);
	}
}
