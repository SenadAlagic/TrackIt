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
				GoalId = 2,
				IsUserPremium = false
			},
			new GeneralUser()
			{
				GeneralUserId = 2,
				UserId = 3,
				Gender = "Male",
				DateOfBirth = DateTime.Now,
				Height = 180,
				Weight = 80,
				TargetWeight = 83,
				ActivityLevelId = 3,
				GoalId = 2,
				IsUserPremium = false
			},
			new GeneralUser()
			{
				GeneralUserId = 3,
				UserId = 4,
				Gender = "Male",
				DateOfBirth = DateTime.Now,
				Height = 170,
				Weight = 70,
				TargetWeight = 73,
				ActivityLevelId = 3,
				GoalId = 2,
				IsUserPremium = false
			},
			new GeneralUser()
			{
				GeneralUserId = 4,
				UserId = 5,
				Gender = "Male",
				DateOfBirth = DateTime.Now,
				Height = 170,
				Weight = 70,
				TargetWeight = 73,
				ActivityLevelId = 3,
				GoalId = 2,
				IsUserPremium = false
			});
		}
	}
}
