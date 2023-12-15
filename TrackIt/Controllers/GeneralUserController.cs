using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class GeneralUserController : BaseCRUDController<GeneralUser, GeneralUserSearchObject, GeneralUserInsertRequest, GeneralUserUpdateRequest>
	{
		IGeneralUserService _service;
		public GeneralUserController(ILogger<BaseController<GeneralUser, GeneralUserSearchObject>> logger, IGeneralUserService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpPut("/updateUser/{id}")]
		public virtual async Task<GeneralUser> UpdateBaseUser(int id, [FromBody] UserUpdateRequest update)
		{
			return await _service.UpdateBaseUser(id, update);
		}

		[HttpPut("/updateActivityLevel/{id}")]
		public virtual async Task<GeneralUser> AddActivityLevel(int id, [FromQuery] int activityLevelId)
		{
			return await _service.AddActivityLevel(id, activityLevelId);
		}

		[HttpPut("/updatePreferences/{id}")]
		public virtual async Task<GeneralUser> AddPreferences(int id, [FromQuery] int[] preferenceIds)
		{
			return await _service.AddPreferences(id, preferenceIds);
		}
	}
}
