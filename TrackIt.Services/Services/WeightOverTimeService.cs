using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class WeightOverTimeService : BaseCRUDService<Model.Models.WeightOverTime, Database.WeightOverTime, WeightOverTimeSearchObject, WeightOverTimeInsertRequest, WeightOverTimeUpdateRequest>, IWeightOverTimeService
	{
		public WeightOverTimeService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<WeightOverTime> AddFilter(IQueryable<WeightOverTime> query, WeightOverTimeSearchObject? search = null)
		{
			if (search?.UserId > 0)
			{
				query = query.Where(wot => wot.UserId == search.UserId);
			}
			return base.AddFilter(query, search);
		}
	}
}
