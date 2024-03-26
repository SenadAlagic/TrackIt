using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class TagData
	{
		public static void SeedData(this EntityTypeBuilder<Tag> entity)
		{
			entity.HasData(
				new Tag()
				{
					TagId = 1,
					Name = "Spicy",
					Description = "This food item has a spicy flavor profile.",
					Color = "#FF5733"
				},
				new Tag()
				{
					TagId = 2,
					Name = "Sour",
					Description = "This food item has a sour taste or flavor.",
					Color = "#F9F900"
				},
				new Tag()
				{
					TagId = 3,
					Name = "Gluten-Free",
					Description = "This food item does not contain gluten.",
					Color = "#66CC99"
				},
				new Tag()
				{
					TagId = 4,
					Name = "Dairy-Free",
					Description = "This food item does not contain dairy products.",
					Color = "#FF99CC"
				},
				new Tag()
				{
					TagId = 5,
					Name = "Eggs",
					Description = "This food item contains eggs.",
					Color = "#FFD700"
				},
				new Tag()
				{
					TagId = 6,
					Name = "Nut-Free",
					Description = "This food item is free from nuts.",
					Color = "#99CCFF"
				},
				new Tag()
				{
					TagId = 7,
					Name = "Low-Carb",
					Description = "This food item is low in carbohydrates.",
					Color = "#FFD700"
				},
				new Tag()
				{
					TagId = 8,
					Name = "High-Protein",
					Description = "This food item is high in protein.",
					Color = "#99CCFF"
				},
				new Tag()
				{
					TagId = 9,
					Name = "Low-Fat",
					Description = "This food item is low in fat.",
					Color = "#66CC99"
				},
				new Tag()
				{
					TagId = 10,
					Name = "Halal",
					Description = "This food item is prepared according to Halal guidelines.",
					Color = "#FF5733"
				}
			);
		}
	}
}
