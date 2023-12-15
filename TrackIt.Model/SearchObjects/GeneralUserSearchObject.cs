namespace TrackIt.Model.SearchObjects
{
	public class GeneralUserSearchObject : BaseSearchObject
	{
		public int Height { get; set; }

		public int Weight { get; set; }

		public int TargetWeight { get; set; }

		public string? FirstName { get; set; }

		public string? LastName { get; set; }

		public bool IsUserIncluded { get; set; }

		public bool IsActivityLevelIncluded { get; set; }

		public bool IsGoalIncluded { get; set; }

		public bool IsPreferenceIncluded { get; set; }
	}
}
