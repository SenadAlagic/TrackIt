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

			var quantityDifference = insert.IngredientQuantity;

			var entity = await set.Where(mi => mi.IngredientId == insert.IngredientId && mi.MealId == insert.MealId).FirstOrDefaultAsync();
			if (entity != null)
			{
				quantityDifference = insert.IngredientQuantity - entity.IngredientQuantity ?? 0; // TODO change MealsIngredient.IngredientQuantity to non nullable
				entity.IngredientQuantity = insert.IngredientQuantity;
			}
			else
			{
				entity = _mapper.Map<MealsIngredient>(new MealsIngredient()
				{
					MealId = insert.MealId,
					IngredientId = insert.IngredientId,
					IngredientQuantity = insert.IngredientQuantity
				});
				set.Add(entity);
			}

			var meal = await mealSet.Where(m => m.MealId == insert.MealId).FirstOrDefaultAsync();
			var ingredient = await ingredientSet.Where(i => i.IngredientId == insert.IngredientId).FirstOrDefaultAsync();
			if (meal != null && ingredient != null)
			{
				meal.Protein += ingredient.Protein * quantityDifference;
				meal.Fat += ingredient.Fat * quantityDifference;
				meal.Carbs += ingredient.Carbs * quantityDifference;
				meal.Calories += ingredient.Calories * quantityDifference;
				mealSet.Update(meal);
			}
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.MealsIngredient>(entity);
		}

		public async Task<Model.Models.MealsIngredient> Remove(Model.Helper.IngredientData ingredientData)
		{
			var set = _context.Set<MealsIngredient>();
			var mealSet = _context.Set<Meal>();

			var entity = await set.Where(mi => mi.MealId == ingredientData.MealId && mi.IngredientId == ingredientData.IngredientId).FirstOrDefaultAsync();
			if (entity != null)
			{
				var meal = await mealSet.Where(m => m.MealId == ingredientData.MealId).FirstOrDefaultAsync();
				if (meal != null)
				{
					meal.Protein -= entity.Ingredient.Protein * entity.IngredientQuantity;
					meal.Fat -= entity.Ingredient.Fat * entity.IngredientQuantity;
					meal.Carbs -= entity.Ingredient.Carbs * entity.IngredientQuantity;
					meal.Calories -= entity.Ingredient.Calories * entity.IngredientQuantity;
					mealSet.Update(meal);
				}
				set.Remove(entity);
				await _context.SaveChangesAsync();
			}
			return _mapper.Map<Model.Models.MealsIngredient>(entity);
		}
	}
}
