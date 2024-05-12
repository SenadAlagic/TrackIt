namespace TrackIt.Model.Requests
{
	public class MealInsertRequest
	{
		public string Name { get; set; }

		public double Fat { get; set; } = 0;

		public double Calories { get; set; } = 0;

		public double Carbs { get; set; } = 0;

		public double Protein { get; set; } = 0;

		public string Description { get; set; }

		public byte[]? Image { get; set; }
	}
}
