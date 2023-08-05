namespace TrackIt.Model.Requests
{
	public class MealUpdateRequest
	{
		public int MealId { get; set; }

		public string? Name { get; set; }

		public string? Description { get; set; }

		public string? Image { get; set; }
	}
}
