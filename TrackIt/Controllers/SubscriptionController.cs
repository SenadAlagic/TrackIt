using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class SubscriptionController : BaseCRUDController<Subscription, SubscriptionSearchObject, SubscriptionInsertRequest, SubscriptionUpdateRequest>
	{
		ISubscriptionService _subscriptionService;
		public SubscriptionController(ILogger<BaseCRUDController<Subscription, SubscriptionSearchObject, SubscriptionInsertRequest, SubscriptionUpdateRequest>> logger, ISubscriptionService service) : base(logger, service)
		{
			_subscriptionService = service;
		}

		[HttpGet("getGroupedByMonth")]
		public async Task<Dictionary<string, int>> GetGroupedByMonth()
		{
			var grouped = await _subscriptionService.GetSubscriptionsGrouped();
			return grouped;
		}
	}
}