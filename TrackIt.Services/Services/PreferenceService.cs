using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class PreferenceService : BaseCRUDService<Model.Models.Preference, Database.Preference, PreferenceSearchObject, PreferenceInsertRequest, PreferenceUpdateRequest>, IPreferenceService
	{
		public PreferenceService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{

		}
	}
}
