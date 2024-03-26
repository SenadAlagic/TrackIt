using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class GeneralUserData
	{
		public static void SeedData(this EntityTypeBuilder<GeneralUser> entity)
		{
			entity.HasData(new GeneralUser()
			{
				GeneralUserId = 1,
				UserId = 2,
				Gender = "Male",
				DateOfBirth = DateTime.Now,
				Height = 176,
				Weight = 72,
				TargetWeight = 74,
				ActivityLevelId = 3,
				GoalId = 2
			});
		}
	}
}
