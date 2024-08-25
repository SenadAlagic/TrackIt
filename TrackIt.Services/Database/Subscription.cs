namespace TrackIt.Services.Database;

public partial class Subscription
{
	public int SubscriptionId { get; set; }

	public int GeneralUserId { get; set; }

	public DateTime PurchaseDate { get; set; }

	public virtual GeneralUser GeneralUser { get; set; } = null!;
}
