using Microsoft.AspNetCore.Mvc;
using TrackIt.Interfaces;
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

		[HttpGet("getForReport")]
		public async Task<int> GetNumberOfItems()
		{
			return await _service.GetNumberOfItems();
		}
	}
}