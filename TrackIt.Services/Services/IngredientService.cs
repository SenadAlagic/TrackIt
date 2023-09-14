using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class IngredientService : BaseCRUDService<Model.Models.Ingredient, Database.Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>, IIngredientService
	{
		public IngredientService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
