using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace TrackIt.Services.Database.Seed
{
	public static class SubscriptionData
	{
		public static void SeedData(this EntityTypeBuilder<Subscription> entity)
		{
			entity.HasData(
				new Subscription() { SubscriptionId = 1, GeneralUserId = 2, PurchaseDate = DateTime.Now.AddMonths(-2) },
				new Subscription() { SubscriptionId = 2, GeneralUserId = 3, PurchaseDate = DateTime.Now.AddMonths(-1) },
				new Subscription() { SubscriptionId = 3, GeneralUserId = 4, PurchaseDate = DateTime.Now.AddMonths(-1) }
				);
		}
	}
}
