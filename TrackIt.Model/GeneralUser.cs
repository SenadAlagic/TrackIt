﻿namespace TrackIt.Model
{
	public class GeneralUser
	{
		public int GeneralUserId { get; set; }

		public int UserId { get; set; }

		public string Gender { get; set; }

		public DateTime DateOfBirth { get; set; }

		public double Height { get; set; }

		public double Weight { get; set; }

		public double TargetWeight { get; set; }

		public int ActivityLevelId { get; set; }

		public virtual ActivityLevel ActivityLevel { get; set; } = null!;

		public virtual User User { get; set; } = null!;
	}
}
