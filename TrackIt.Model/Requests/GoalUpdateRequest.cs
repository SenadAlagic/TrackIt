using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class GoalUpdateRequest
	{
		[Required]
		[StringLength(50)]
		public string? Name { get; set; }

		[Required]
		[StringLength(100)]
		public string? Description { get; set; }

		[Required]
		[Range(0, 500)]
		public double? TargetProtein { get; set; }

		[Required]
		[Range(0, 2000)]
		public int? TargetCalories { get; set; }

		public byte[]? Image { get; set; }
	}
}
