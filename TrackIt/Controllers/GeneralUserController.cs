using Microsoft.AspNetCore.Authorization;
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

		[HttpPut("/selectActivityLevel/{id}")]
		public virtual async Task<GeneralUser> SelectActivityLevel(int id, [FromQuery] int activityLevelId)
		{
			return await _service.SelectActivityLevel(id, activityLevelId);
		}

		[HttpPut("/selectGoal/{id}")]
		public virtual async Task<GeneralUser> SelectGoal(int id, [FromQuery] int goalId)
		{
			return await _service.SelectGoal(id, goalId);
		}

		[HttpPut("/selectPreferences/{id}")]
		public virtual async Task<GeneralUser> SelectPreferences(int id, [FromQuery] int[] preferenceIds)
		{
			return await _service.SelectPreferences(id, preferenceIds);
		}

		[AllowAnonymous]
		public override Task<GeneralUser> Insert([FromBody] GeneralUserInsertRequest insert)
		{
			return base.Insert(insert);
		}

		[HttpGet("/getFullInfo/{id}")]
		public async Task<GeneralUser> GetFullUserData(int id)
		{
			return await _service.GetFullUserData(id);
		}
	}
}
