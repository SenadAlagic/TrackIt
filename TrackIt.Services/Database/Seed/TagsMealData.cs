using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class TagsMealData
	{
		public static void SeedData(this EntityTypeBuilder<TagsMeal> entity)
		{
			entity.HasData(
				new TagsMeal() { TagMealId = 1, TagId = 1, MealId = 1 },
				new TagsMeal() { TagMealId = 2, TagId = 3, MealId = 1 },
				new TagsMeal() { TagMealId = 3, TagId = 4, MealId = 1 },
				new TagsMeal() { TagMealId = 4, TagId = 8, MealId = 1 },
				new TagsMeal() { TagMealId = 5, TagId = 10, MealId = 1 },
				new TagsMeal() { TagMealId = 6, TagId = 1, MealId = 2 },
				new TagsMeal() { TagMealId = 7, TagId = 2, MealId = 2 },
				new TagsMeal() { TagMealId = 8, TagId = 3, MealId = 2 },
				new TagsMeal() { TagMealId = 9, TagId = 4, MealId = 2 },
				new TagsMeal() { TagMealId = 10, TagId = 6, MealId = 2 },
				new TagsMeal() { TagMealId = 11, TagId = 7, MealId = 2 },
				new TagsMeal() { TagMealId = 12, TagId = 8, MealId = 2 },
				new TagsMeal() { TagMealId = 13, TagId = 2, MealId = 3 },
				new TagsMeal() { TagMealId = 14, TagId = 3, MealId = 3 },
				new TagsMeal() { TagMealId = 15, TagId = 4, MealId = 3 },
				new TagsMeal() { TagMealId = 16, TagId = 6, MealId = 3 },
				new TagsMeal() { TagMealId = 17, TagId = 8, MealId = 3 },
				new TagsMeal() { TagMealId = 18, TagId = 10, MealId = 3 },
				new TagsMeal() { TagMealId = 19, TagId = 2, MealId = 4 },
				new TagsMeal() { TagMealId = 20, TagId = 3, MealId = 4 },
				new TagsMeal() { TagMealId = 21, TagId = 4, MealId = 4 },
				new TagsMeal() { TagMealId = 22, TagId = 6, MealId = 4 },
				new TagsMeal() { TagMealId = 23, TagId = 7, MealId = 4 },
				new TagsMeal() { TagMealId = 24, TagId = 10, MealId = 4 },
				new TagsMeal() { TagMealId = 25, TagId = 3, MealId = 5 },
				new TagsMeal() { TagMealId = 26, TagId = 4, MealId = 5 },
				new TagsMeal() { TagMealId = 27, TagId = 6, MealId = 5 },
				new TagsMeal() { TagMealId = 28, TagId = 7, MealId = 5 },
				new TagsMeal() { TagMealId = 29, TagId = 10, MealId = 5 }
			);
		}
	}
}
