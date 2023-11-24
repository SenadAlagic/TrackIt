using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class AdminInsertRequest
	{
		[Required]
		[MinLength(3)]
		public string FirstName { get; set; }

		[Required]
		[MinLength(3)]
		public string LastName { get; set; }

		[Required]
		[EmailAddress]
		public string Email { get; set; }

		[Required]
		[MinLength(5)]
		public string Username { get; set; }

		[Required]
		[MinLength(6)]
		public string Password { get; set; }
	}
}
