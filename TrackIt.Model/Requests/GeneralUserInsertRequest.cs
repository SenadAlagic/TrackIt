namespace TrackIt.Model.Requests
{
	public class GeneralUserInsertRequest
	{
		public string FirstName { get; set; }

		public string LastName { get; set; }

		public string Email { get; set; }

		public string Username { get; set; }

		public string Password { get; set; }


		public string Gender { get; set; }

		public DateTime DateOfBirth { get; set; }

		public double Height { get; set; }

		public double Weight { get; set; }

		public double TargetWeight { get; set; }

		public int ActivityLevelId { get; set; }

	}
}
