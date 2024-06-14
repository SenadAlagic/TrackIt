using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TrackIt.Interfaces;
using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class TagController : BaseCRUDController<Tag, TagSearchObject, TagInsertRequest, TagUpdateRequest>, IReportable
	{
		ITagService _service;
		public TagController(ILogger<BaseController<Tag, TagSearchObject>> logger, ITagService service) : base(logger, service)
		{
			_service = service;
		}

		[AllowAnonymous]
		public override Task<PagedResult<Tag>> Get([FromQuery] TagSearchObject search)
		{
			return base.Get(search);
		}

		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}