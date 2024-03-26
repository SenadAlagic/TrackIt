using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class AdminData
	{
		public static void SeedData(this EntityTypeBuilder<Admin> entity)
		{
			entity.HasData(new Admin() { AdminId = 1, UserId = 1 });
		}
	}
}
