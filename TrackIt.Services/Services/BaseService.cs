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
			var result = new PagedResult<T>();

			query = AddFilter(query, search);
			query = AddInclude(query, search);

			if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
			{
				query = query.Take(search.PageSize.Value).Skip(search.PageSize.Value * search.Page.Value);
			}

			var list = await query.ToListAsync();
			result.Count = await query.CountAsync();
			result.Result = _mapper.Map<List<T>>(list);
			return result;
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
