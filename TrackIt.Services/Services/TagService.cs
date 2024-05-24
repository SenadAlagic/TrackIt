using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class TagService : BaseCRUDService<Model.Models.Tag, Database.Tag, TagSearchObject, TagInsertRequest, TagUpdateRequest>, ITagService
	{
		TrackItContext _context;
		public TagService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
			_context = context;
		}
		public override IQueryable<Tag> AddFilter(IQueryable<Tag> query, TagSearchObject? search = null)
		{
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(tag => tag.Name.ToLower().Contains(search.Name.ToLower()));
			}
			if (search?.Description.IsNullOrEmpty() == false)
			{
				query = query.Where(tag => tag.Description.ToLower().Contains(search.Description.ToLower()));
			}
			return base.AddFilter(query, search);
		}

		public async Task<int> GetNumberOfItems()
		{
			return await _context.Tags.CountAsync();
		}
	}
}
