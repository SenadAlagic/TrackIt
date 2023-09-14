namespace TrackIt.Model.Requests
{
	public class GoalUpdateRequest
	{
		public string? Name { get; set; }

		public string? Description { get; set; }

		public double? TargetProtein { get; set; }

		public int? TargetCalories { get; set; }
	}
}
