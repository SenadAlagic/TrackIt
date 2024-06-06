using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class UserController : BaseCRUDController<User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
	{
		IUserService _service;
		public UserController(ILogger<BaseController<User, UserSearchObject>> logger, IUserService service) : base(logger, service)
		{
			_service = service;
		}

		[HttpPost("admin_login")]
		[AllowAnonymous]
		public async Task<AuthResponse> AdminLogin([FromBody] LoginRequest login)
		{
			return await _service.AuthenticateUser(login.email, login.password, "admin");
		}

		[HttpPost("user_login")]
		[AllowAnonymous]
		public async Task<AuthResponse> UserLogin([FromBody] LoginRequest login)
		{
			return await _service.AuthenticateUser(login.email, login.password, "generalUser");
		}
	}
}