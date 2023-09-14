using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class TagController : BaseCRUDController<Tag, TagSearchObject, TagInsertRequest, TagUpdateRequest>
	{
		public TagController(ILogger<BaseController<Tag, TagSearchObject>> logger, ITagService service) : base(logger, service)
		{
		}
	}
}