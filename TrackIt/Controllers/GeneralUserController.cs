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
		public GeneralUserController(ILogger<BaseController<GeneralUser, GeneralUserSearchObject>> logger, IGeneralUserService service) : base(logger, service)
		{
		}
	}
}
