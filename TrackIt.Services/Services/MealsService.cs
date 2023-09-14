using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class MealsService : BaseCRUDService<Model.Models.Meal, Database.Meal, MealSearchObject, MealInsertRequest, MealUpdateRequest>, IMealsService
	{
		public MealsService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Meal> AddFilter(IQueryable<Meal> query, MealSearchObject? search = null)
		{
			if (search?.IngredientIds?.Length > 0)
			{

			}
			return base.AddFilter(query, search);
		}
	}
}
