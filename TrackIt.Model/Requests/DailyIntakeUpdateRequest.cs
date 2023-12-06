using TrackIt.Model.DTOs;

namespace TrackIt.Model.Requests
{
	public class DailyIntakeUpdateRequest
	{
		public int UserId { get; set; }
		public MealMini Meal { get; set; }
		public int Quantity { get; set; }
	}
}
