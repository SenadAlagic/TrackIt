namespace TrackIt.Model
{
	public class ActivityLevel
	{
		public int ActivityLevelId { get; set; }

		public string Name { get; set; } = null!;

		public double Multiplier { get; set; }
	}
}
