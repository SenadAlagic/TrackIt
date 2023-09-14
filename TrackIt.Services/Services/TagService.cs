using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class TagService : BaseCRUDService<Model.Models.Tag, Database.Tag, TagSearchObject, TagInsertRequest, TagUpdateRequest>, ITagService
	{
		public TagService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
