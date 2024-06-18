using AutoMapper;
using Microsoft.EntityFrameworkCore;
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
			var mealSet = _context.Set<Meal>();
			var ingredientSet = _context.Set<Ingredient>();

			var entity = _mapper.Map<MealsIngredient>(new MealsIngredient()
			{
				MealId = insert.MealId,
				IngredientId = insert.IngredientId,
				IngredientQuantity = insert.IngredientQuantity
			});
			set.Add(entity);

			var meal = await mealSet.Where(m => m.MealId == insert.MealId).FirstOrDefaultAsync();
			var ingredient = await ingredientSet.Where(i => i.IngredientId == insert.IngredientId).FirstOrDefaultAsync();
			if (meal != null && ingredient != null)
			{
				meal.Protein += ingredient.Protein * (insert.IngredientQuantity / 100.0);
				meal.Fat += ingredient.Fat * (insert.IngredientQuantity / 100.0);
				meal.Carbs += ingredient.Carbs * (insert.IngredientQuantity / 100.0);
				meal.Calories += ingredient.Calories * (insert.IngredientQuantity / 100.0);
				mealSet.Update(meal);
			}
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.MealsIngredient>(entity);
		}
	}
}
