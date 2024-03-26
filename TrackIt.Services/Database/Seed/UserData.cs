using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class UserData
	{
		public static void SeedData(this EntityTypeBuilder<User> entity)
		{
			entity.HasData(
				new User
				{
					UserId = 1,
					FirstName = "Admin",
					LastName = "Adminovic",
					Email = "adminovic@admin.com",
					Username = "admin",
					Password = "mVxtzwvfIpzwWEF4IBbOtCNin2o=",
					Salt = "gDWkSe9syPEM+A2/JF3Heg=="
				},
				new User
				{
					UserId = 2,
					FirstName = "Senad",
					LastName = "Alagic",
					Email = "senad@gmail.com",
					Username = "senad",
					Password = "xLZ3Aq2uZqTwecvjM20Wo1Qkx6k=",
					Salt = "bBJ2aGPhyzr+SUEggHwwEA=="
				}
			);
		}
	}
}
