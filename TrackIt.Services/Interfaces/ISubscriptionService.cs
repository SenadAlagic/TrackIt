using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface ISubscriptionService : ICRUDService<Subscription, SubscriptionSearchObject, SubscriptionInsertRequest, SubscriptionUpdateRequest>
	{
		Task<Dictionary<string, int>> GetSubscriptionsGrouped();
	}
}
