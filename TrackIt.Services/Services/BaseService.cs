using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Helper;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
	{
		protected TrackItContext _context;
		protected IMapper _mapper { get; set; }

		public BaseService(TrackItContext context, IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}

		public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
		{
			var query = _context.Set<TDb>().AsQueryable();

			query = AddFilter(query, search);
			query = AddInclude(query, search);

			var totalCount = await query.CountAsync();

			if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
			{
				query = query.Skip(search.PageSize.Value * search.Page.Value).Take(search.PageSize.Value);
			}

			var list = await query.ToListAsync();
			var items = _mapper.Map<List<T>>(list);

			return PagedResult<T>.Create(items, search.Page.Value, search.PageSize.Value, totalCount);
		}

		public virtual async Task<T> GetById(int id)
		{
			var entity = await _context.Set<TDb>().FindAsync(id);
			return _mapper.Map<T>(entity);
		}

		public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
		{
			return query;
		}

		public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
		{
			return query;
		}
	}
}
