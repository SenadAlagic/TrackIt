using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class MealsService : IMealsService
	{
		TrackItContext _context;

		public MealsService(TrackItContext context)
		{
			_context = context;
		}

		public IList<Model.Meal> Get()
		{
			throw new NotImplementedException();
		}
	}
}
