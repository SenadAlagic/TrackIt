namespace TrackIt.Model.Requests
{
	public class DailyIntakeInsertRequest
	{
		public int UserId { get; set; }

		public double? Calories { get; set; }

		public double? Carbs { get; set; }

		public double? Protein { get; set; }

		public double? Fat { get; set; }

		public double? Fiber { get; set; }

		// TODO might have to add a proper User user { get; set; }
	}
}
