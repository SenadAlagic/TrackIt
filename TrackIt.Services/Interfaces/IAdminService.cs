using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IAdminService : ICRUDService<Admin, AdminSearchObject, AdminInsertRequest, AdminUpdateRequest>
	{
	}
}
