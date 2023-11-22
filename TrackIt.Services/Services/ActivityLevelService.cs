using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class ActivityLevelService : BaseCRUDService<Model.Models.ActivityLevel, Database.ActivityLevel, ActivityLevelSearchObject, ActivityLevelInsertRequest, ActivityLevelUpdateRequest>, IActivityLevelService
	{
		public ActivityLevelService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{

		}
		public override IQueryable<ActivityLevel> AddFilter(IQueryable<ActivityLevel> query, ActivityLevelSearchObject? search = null)
		{
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(level => level.Name.ToLower().Contains(search.Name.ToLower()));
			}
			if (search?.Multiplier.HasValue == true)
			{
				query = query.Where(level => level.Multiplier == search.Multiplier);
			}
			return base.AddFilter(query, search);
		}
	}
}
