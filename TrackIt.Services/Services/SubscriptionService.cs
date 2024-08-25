using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class SubscriptionService : BaseCRUDService<Model.Models.Subscription, Subscription, SubscriptionSearchObject, SubscriptionInsertRequest, SubscriptionUpdateRequest>, ISubscriptionService
	{
		public SubscriptionService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
			_context = context;
		}

		public async Task<Dictionary<string, int>> GetSubscriptionsGrouped()
		{
			var set = _context.Set<Subscription>();
			var now = DateTime.Now;
			var startDate = new DateTime(now.Year, now.Month, 1).AddMonths(-2);

			var query = _context.Subscriptions
				.Where(s => s.PurchaseDate >= startDate)
				.GroupBy(s => new { Year = s.PurchaseDate.Year, Month = s.PurchaseDate.Month })
				.Select(g => new { YearMonth = $"{g.Key.Year}-{g.Key.Month:D2}", Count = g.Count() });
			return await query.ToDictionaryAsync(g => g.YearMonth, g => g.Count);
		}
	}
}
