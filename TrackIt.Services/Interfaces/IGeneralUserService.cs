using TrackIt.Model;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IGeneralUserService : IService<GeneralUser, GeneralUserSearchObject>
	{
		GeneralUser Insert(GeneralUserInsertRequest request);
	}
}
