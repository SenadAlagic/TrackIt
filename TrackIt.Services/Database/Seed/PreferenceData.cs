using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class PreferenceData
	{
		public static void SeedData(this EntityTypeBuilder<Preference> entity)
		{
			entity.HasData(
				new Preference()
				{
					PreferenceId = 1,
					Name = "Spicy"
				},
				new Preference()
				{
					PreferenceId = 2,
					Name = "Sour"
				},
				new Preference()
				{
					PreferenceId = 3,
					Name = "Gluten-Free"
				},
				new Preference()
				{
					PreferenceId = 4,
					Name = "Dairy-Free"
				},
				new Preference()
				{
					PreferenceId = 5,
					Name = "Eggs"
				},
				new Preference()
				{
					PreferenceId = 6,
					Name = "Nut-Free"
				},
				new Preference()
				{
					PreferenceId = 7,
					Name = "Low-Carb"
				},
				new Preference()
				{
					PreferenceId = 8,
					Name = "High-Protein"
				},
				new Preference()
				{
					PreferenceId = 9,
					Name = "Low-Fat"
				},
				new Preference()
				{
					PreferenceId = 10,
					Name = "Halal"
				}
			);
		}
	}
}
