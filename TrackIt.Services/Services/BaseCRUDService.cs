using AutoMapper;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;

namespace TrackIt.Services.Services
{
	public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where TSearch : BaseSearchObject where TDb : class where T : class
	{
		public BaseCRUDService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public virtual async Task BeforeInsert(TDb entity, TInsert insert)
		{

		}

		public virtual async Task<T> Insert(TInsert insert)
		{
			var set = _context.Set<TDb>();
			TDb entity = _mapper.Map<TDb>(insert);
			set.Add(entity);
			await BeforeInsert(entity, insert);
			await _context.SaveChangesAsync();
			return _mapper.Map<T>(entity);
		}

		public virtual async Task<T> Update(int id, TUpdate update)
		{
			var set = _context.Set<TDb>();
			var entity = await set.FindAsync(id);
			_mapper.Map(update, entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<T>(entity);
		}
	}
}
