namespace TrackIt.Model.Requests
{
	public class GoalInsertRequest
	{
		public string? Name { get; set; }

		public string? Description { get; set; }

		public double? TargetProtein { get; set; }

		public int? TargetCalories { get; set; }

		public byte[] Image { get; set; }
	}
}
