using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class UsersPreferencesService : BaseCRUDService<Model.Models.UsersPreference, Database.UsersPreference, UsersPreferencesSearchObject, UsersPreferencesInsertRequest, UsersPreferencesUpdateRequest>, IUsersPreferenceService
	{
		public UsersPreferencesService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<UsersPreference> AddFilter(IQueryable<UsersPreference> query, UsersPreferencesSearchObject? search = null)
		{
			if (search?.PreferenceId > 0)
			{
				query = query.Where(up => up.PreferenceId == search.PreferenceId);
			}
			if (search?.UserId > 0)
			{
				query = query.Where(up => up.UserId == search.UserId);
			}
			return base.AddFilter(query, search);
		}

		public override async Task<Model.Models.UsersPreference> Insert(UsersPreferencesInsertRequest insert)
		{
			var set = _context.Set<UsersPreference>();
			var entity = _mapper.Map<UsersPreference>(new UsersPreference() { UserId = insert.UserId, PreferenceId = insert.PreferenceId });
			set.Add(entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.UsersPreference>(entity);
		}

		public async Task<Model.Models.UsersPreference> Remove(int preferenceId)
		{
			var set = _context.Set<UsersPreference>();
			var entity = await set.Where(up => up.PreferenceId == preferenceId).FirstOrDefaultAsync();
			if (entity != null)
			{
				set.Remove(entity);
				await _context.SaveChangesAsync();
			}
			return _mapper.Map<Model.Models.UsersPreference>(entity);
		}
	}
}
