﻿namespace TrackIt.Model.Requests
{
	public class UserUpdateRequest
	{
		public string? FirstName { get; set; }

		public string? LastName { get; set; }

		public string? Email { get; set; }

		public string? Password { get; set; }

		public string? PasswordConfirm { get; set; }
	}
}
