using TrackIt.Model;
using TrackIt.Model.Requests;

namespace TrackIt.Services.Interfaces
{
	public interface IGeneralUserService
	{
		List<GeneralUser> Get();
		GeneralUser Insert(GeneralUserInsertRequest request);
	}
}
