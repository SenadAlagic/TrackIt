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
				},
				new User
				{
					UserId = 3,
					FirstName = "Dummy",
					LastName = "Dummy",
					Email = "dummy1@gmail.com",
					Username = "dummy2",
					Password = "xLZ3Aq2uZqTwecvjM20Wo1Qkx6k=",
					Salt = "bBJ2aGPhyzr+SUEggHwwEA=="
				},
				new User
				{
					UserId = 4,
					FirstName = "Dummy",
					LastName = "Dummy",
					Email = "dummy2@gmail.com",
					Username = "dummy2",
					Password = "xLZ3Aq2uZqTwecvjM20Wo1Qkx6k=",
					Salt = "bBJ2aGPhyzr+SUEggHwwEA=="
				},
				new User
				{
					UserId = 5,
					FirstName = "Dummy",
					LastName = "Dummy",
					Email = "dummy3@gmail.com",
					Username = "dummy3",
					Password = "xLZ3Aq2uZqTwecvjM20Wo1Qkx6k=",
					Salt = "bBJ2aGPhyzr+SUEggHwwEA=="
				}
			);
		}
	}
}
