using AutoMapper;
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
		public override async Task<Model.Models.UsersPreference> Insert(UsersPreferencesInsertRequest insert)
		{
			var set = _context.Set<UsersPreference>();
			var entity = _mapper.Map<UsersPreference>(new UsersPreference() { UserId = insert.UserId, PreferenceId = insert.PreferenceId });
			set.Add(entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.UsersPreference>(entity);
		}
	}
}
