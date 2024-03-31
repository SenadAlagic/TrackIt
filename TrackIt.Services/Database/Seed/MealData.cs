﻿using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class MealData
	{
		public static void SeedData(this EntityTypeBuilder<Meal> entity)
		{
			entity.HasData(
				new Meal
				{
					MealId = 1,
					Fat = 15.5,
					Calories = 471,
					Carbs = 24.6,
					Protein = 30.1,
					Name = "Salmon Quinoa Bowl",
					Description = "A delicious and nutritious bowl featuring grilled salmon, cooked quinoa, mixed salad greens, bell peppers, and cucumber slices, drizzled with olive oil for a delightful and flavorful experience.",
				},
				new Meal
				{
					MealId = 2,
					Fat = 4.4,
					Calories = 374,
					Carbs = 44,
					Protein = 32.8,
					Name = "Chicken and Broccoli Stir-Fry",
					Description = "A savory stir-fry combining tender chicken breast and broccoli florets, seasoned with garlic and ginger, and served over a bed of lentils and brown rice for a wholesome meal.",
					Image = null
				},
				new Meal
				{
					MealId = 3,
					Fat = 2.6,
					Calories = 213,
					Carbs = 31.5,
					Protein = 9.1,
					Name = "Vegetarian Chickpea Curry",
					Description = "A flavorful vegetarian curry made with chickpeas, onions, bell peppers, and zucchini, simmered in a rich tomato-based sauce, and served over a bed of aromatic rice.",
					Image = null,
				},
				new Meal
				{
					MealId = 4,
					Fat = 4.8,
					Calories = 143,
					Carbs = 5,
					Protein = 9.9,
					Name = "Tofu and Vegetable Skewers",
					Description = "Delicious tofu and colorful bell pepper skewers, grilled to perfection and served with cherry tomatoes and onions, accompanied by a zesty dipping sauce.",
					Image = null
				},
				new Meal
				{
					MealId = 5,
					Fat = 5.8,
					Calories = 317,
					Carbs = 53.1,
					Protein = 10.4,
					Name = "Sweet Potato and Black Bean Burrito",
					Description = "A satisfying burrito filled with flavorful mashed sweet potatoes and black beans, along with diced tomatoes, onions, and creamy avocado, all wrapped in a soft tortilla.",
					Image = null
				})
			;

		}
	}
}