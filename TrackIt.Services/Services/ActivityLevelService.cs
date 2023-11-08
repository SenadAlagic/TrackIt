using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class ActivityLevelService : BaseCRUDService<Model.Models.ActivityLevel, Database.ActivityLevel, ActivityLevelSearchObject, ActivityLevelInsertRequest, ActivityLevelUpdateRequest>, IActivityLevelService
	{
		public ActivityLevelService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{

		}

	}
}
