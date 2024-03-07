using System.ComponentModel.DataAnnotations;

namespace TrackIt.Model.Requests
{
	public class GeneralUserInsertRequest
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

		[Required]
		public string Gender { get; set; }

		[Required]
		public DateTime DateOfBirth { get; set; }

		public double Height { get; set; }

		public double Weight { get; set; }

		public double TargetWeight { get; set; }

		public int ActivityLevelId { get; set; }

		public int GoalId { get; set; }

	}
}
