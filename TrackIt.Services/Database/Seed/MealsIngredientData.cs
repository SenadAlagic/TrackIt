﻿using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class MealsIngredientData
	{
		public static void SeedData(this EntityTypeBuilder<MealsIngredient> entity)
		{
			entity.HasData(
				new MealsIngredient()
				{
					MealIngredientsId = 1,
					MealId = 1,
					IngredientId = 2,
					IngredientQuantity = 200
				},
				new MealsIngredient()
				{
					MealIngredientsId = 2,
					MealId = 1,
					IngredientId = 9,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 3,
					MealId = 1,
					IngredientId = 7,
					IngredientQuantity = 15
				},
				new MealsIngredient()
				{
					MealIngredientsId = 4,
					MealId = 2,
					IngredientId = 1,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 5,
					MealId = 2,
					IngredientId = 4,
					IngredientQuantity = 200
				},
				new MealsIngredient()
				{
					MealIngredientsId = 6,
					MealId = 2,
					IngredientId = 8,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 7,
					MealId = 2,
					IngredientId = 3,
					IngredientQuantity = 100
				},
				new MealsIngredient()
				{
					MealIngredientsId = 8,
					MealId = 3,
					IngredientId = 10,
					IngredientQuantity = 200
				},
				new MealsIngredient()
				{
					MealIngredientsId = 9,
					MealId = 3,
					IngredientId = 3,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 10,
					MealId = 4,
					IngredientId = 6,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 11,
					MealId = 4,
					IngredientId = 7,
					IngredientQuantity = 150
				},
				new MealsIngredient()
				{
					MealIngredientsId = 12,
					MealId = 5,
					IngredientId = 5,
					IngredientQuantity = 50
				},
				new MealsIngredient()
				{
					MealIngredientsId = 13,
					MealId = 5,
					IngredientId = 6,
					IngredientQuantity = 50
				}
			);
		}
	}
}