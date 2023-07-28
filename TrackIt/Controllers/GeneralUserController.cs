using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Requests;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class GeneralUserController : ControllerBase
	{
		private readonly IGeneralUserService _service;
		private readonly ILogger<GeneralUserController> _logger;

		public GeneralUserController(ILogger<GeneralUserController> logger, IGeneralUserService service)
		{
			_service = service;
			_logger = logger;
		}

		[HttpGet()]
		public IEnumerable<Model.GeneralUser> Get()
		{
			return _service.Get();
		}

		[HttpPost]
		public Model.GeneralUser Insert(GeneralUserInsertRequest request)
		{
			return _service.Insert(request);
		}

	}
}
