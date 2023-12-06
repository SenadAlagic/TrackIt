using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IDailyIntakeService : ICRUDService<DailyIntake, DailyIntakeSearchObject, DailyIntakeInsertRequest, DailyIntakeUpdateRequest>
	{
	}
}
