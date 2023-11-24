using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class AdminController : BaseCRUDController<Admin, AdminSearchObject, AdminInsertRequest, AdminUpdateRequest>
	{
		public AdminController(ILogger<BaseController<Admin, AdminSearchObject>> logger, IAdminService service) : base(logger, service)
		{
		}
	}
}