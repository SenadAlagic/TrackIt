using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class AdminUpdateRequest
	{

		[Required]
		[EmailAddress]
		public string Email { get; set; }
	}
}
