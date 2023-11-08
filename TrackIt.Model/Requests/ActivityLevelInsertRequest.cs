using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class ActivityLevelInsertRequest
	{
		[Required]
		[MinLength(3)]
		public string Name { get; set; }

		[Required]
		public double Multiplier { get; set; }
	}
}
