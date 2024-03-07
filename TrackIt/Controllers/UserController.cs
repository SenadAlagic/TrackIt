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

		[HttpPost("login")]
		[AllowAnonymous]
		public async Task<AuthResponse> Login(string email, string password)
		{
			return await _service.AuthenticateUser(email, password);
		}
	}
}