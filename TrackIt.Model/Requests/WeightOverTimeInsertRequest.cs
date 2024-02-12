namespace TrackIt.Model.Requests
{
	public class WeightOverTimeInsertRequest
	{

		public int UserId { get; set; }

		public double? Weight { get; set; }

		public DateTime? DateLogged { get; set; }

		public string? Comment { get; set; }
	}
}
