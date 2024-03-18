using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class ActivityLevelUpdateRequest
	{
		[MinLength(3)]
		public string? Name { get; set; }

		public double? Multiplier { get; set; }

		public byte[]? Image { get; set; }
	}
}