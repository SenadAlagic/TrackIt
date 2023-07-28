using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Requests;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class UserController : ControllerBase
	{
		private readonly IUserService _service;
		private readonly ILogger<UserController> _logger;

		public UserController(ILogger<UserController> logger, IUserService service)
		{
			_service = service;
			_logger = logger;
		}

		[HttpGet()]
		public IEnumerable<Model.User> Get()
		{
			return _service.Get();
		}

		[HttpPut("{id}")]
		public Model.User Update(int id, UserUpdateRequest request)
		{
			return _service.Update(id, request);
		}
	}
}