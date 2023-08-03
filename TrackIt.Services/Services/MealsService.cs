using AutoMapper;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class MealsService : BaseService<Model.Meal, Database.Meal, MealSearchObject>, IMealsService
	{
		public MealsService(TrackItContext context, IMapper mapper) :
			base(context, mapper)
		{
		}

		public override IQueryable<Meal> AddFilter(IQueryable<Meal> query, MealSearchObject? search = null)
		{
			if (!string.IsNullOrWhiteSpace(search?.Name))
			{
				query = query.Where(x => x.Name == search.Name);
			}

			return base.AddFilter(query, search);
		}
	}
}
