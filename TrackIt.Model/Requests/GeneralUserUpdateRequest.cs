using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class GeneralUserUpdateRequest
	{
		[EmailAddress]
		public string? Email { get; set; }

		public int? ActivityLevelId { get; set; }

		public int? TargetWeight { get; set; }

		public int? CurrentWeight { get; set; }

	}
}
