using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class MealsIngredientsService : BaseCRUDService<Model.Models.MealsIngredient, Database.MealsIngredient, MealsIngredientsSearchObject, MealsIngredientsInsertRequest, MealsIngredientsUpdateRequest>, IMealsIngredientsService
	{
		public MealsIngredientsService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override async Task<Model.Models.MealsIngredient> Insert(MealsIngredientsInsertRequest insert)
		{
			var set = _context.Set<MealsIngredient>();
			var entity = _mapper.Map<MealsIngredient>(new MealsIngredient() { MealId = insert.MealId, IngredientId = insert.IngredientId });
			set.Add(entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.MealsIngredient>(entity);
		}

		public async Task<Model.Models.MealsIngredient> Remove(int ingredientId)
		{
			var set = _context.Set<MealsIngredient>();
			var entity = await set.FindAsync(ingredientId);
			if (entity != null)
			{
				set.Remove(entity);
				await _context.SaveChangesAsync();
			}
			return _mapper.Map<Model.Models.MealsIngredient>(entity);
		}
	}
}
