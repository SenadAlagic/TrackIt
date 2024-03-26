namespace TrackIt.Model.Requests
{
	public class MealUpdateRequest
	{
		public string? Name { get; set; }

		public string? Description { get; set; }

		public byte[]? Image { get; set; }
	}
}
