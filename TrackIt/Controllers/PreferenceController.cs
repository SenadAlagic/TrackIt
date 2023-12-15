using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class PreferenceController : BaseCRUDController<Preference, PreferenceSearchObject, PreferenceInsertRequest, PreferenceUpdateRequest>
	{
		public PreferenceController(ILogger<BaseController<Preference, PreferenceSearchObject>> logger, IPreferenceService service) : base(logger, service)
		{
		}
	}
}