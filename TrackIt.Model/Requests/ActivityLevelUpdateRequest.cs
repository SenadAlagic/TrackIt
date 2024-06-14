using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class ActivityLevelUpdateRequest
	{
		[MinLength(3)]
		[Required]
		public string? Name { get; set; }

		[Required]
		public double? Multiplier { get; set; }

		public byte[]? Image { get; set; }
	}
}