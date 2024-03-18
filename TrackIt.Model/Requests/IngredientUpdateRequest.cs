﻿namespace TrackIt.Model.Requests
{
	public class IngredientUpdateRequest
	{
		public string? Name { get; set; }

		public double? Protein { get; set; }

		public double? Fat { get; set; }

		public double? Carbs { get; set; }

		public double? Calories { get; set; }

		public byte[]? Image { get; set; }
	}
}
