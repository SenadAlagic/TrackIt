﻿namespace TrackIt.Model.Models
{
	public class ActivityLevel
	{
		public int ActivityLevelId { get; set; }

		public string Name { get; set; } = null!;

		public double Multiplier { get; set; }

		public byte[]? Image { get; set; }
	}
}
