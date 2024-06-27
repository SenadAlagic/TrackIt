using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class UsersMealsData
	{
		public static void SeedData(this EntityTypeBuilder<UsersMeal> entity)
		{
			entity.HasData(
			new UsersMeal()
			{
				UsersMealsId = 1,
				UserId = 1,
				MealId = 1,
				DateConsumed = DateTime.Now.AddDays(-1),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 2,
				UserId = 1,
				MealId = 2,
				DateConsumed = DateTime.Now.AddDays(-1),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 3,
				UserId = 1,
				MealId = 3,
				DateConsumed = DateTime.Now.AddDays(-1),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 4,
				UserId = 1,
				MealId = 1,
				DateConsumed = DateTime.Now.AddDays(-2),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 5,
				UserId = 1,
				MealId = 2,
				DateConsumed = DateTime.Now.AddDays(-2),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 6,
				UserId = 1,
				MealId = 3,
				DateConsumed = DateTime.Now.AddDays(-2),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 7,
				UserId = 1,
				MealId = 2,
				DateConsumed = DateTime.Now.AddDays(-3),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 8,
				UserId = 1,
				MealId = 3,
				DateConsumed = DateTime.Now.AddDays(-3),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 9,
				UserId = 1,
				MealId = 4,
				DateConsumed = DateTime.Now.AddDays(-3),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 10,
				UserId = 1,
				MealId = 4,
				DateConsumed = DateTime.Now.AddDays(-4),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 11,
				UserId = 1,
				MealId = 5,
				DateConsumed = DateTime.Now.AddDays(-4),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 12,
				UserId = 1,
				MealId = 6,
				DateConsumed = DateTime.Now.AddDays(-4),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 13,
				UserId = 1,
				MealId = 6,
				DateConsumed = DateTime.Now.AddDays(-5),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 14,
				UserId = 1,
				MealId = 7,
				DateConsumed = DateTime.Now.AddDays(-5),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 15,
				UserId = 1,
				MealId = 8,
				DateConsumed = DateTime.Now.AddDays(-5),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 16,
				UserId = 1,
				MealId = 9,
				DateConsumed = DateTime.Now.AddDays(-5),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 17,
				UserId = 1,
				MealId = 1,
				DateConsumed = DateTime.Now.AddDays(-6),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 18,
				UserId = 1,
				MealId = 9,
				DateConsumed = DateTime.Now.AddDays(-6),
				Servings = 1,
			},
			new UsersMeal()
			{
				UsersMealsId = 19,
				UserId = 1,
				MealId = 4,
				DateConsumed = DateTime.Now.AddDays(-6),
				Servings = 1,
			}
			);
		}
	}
}
