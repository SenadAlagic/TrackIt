using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class GeneralUserController : BaseController<Model.GeneralUser, GeneralUserSearchObject>
	{
		public GeneralUserController(ILogger<BaseController<Model.GeneralUser, GeneralUserSearchObject>> logger, IGeneralUserService service) : base(logger, service)
		{

		}
	}
}
