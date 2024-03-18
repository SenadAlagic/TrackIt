namespace TrackIt.Model.Requests
{
	public class MealInsertRequest
	{
		public string Name { get; set; }

		public double Fat { get; set; }

		public double Calories { get; set; }

		public double Carbs { get; set; }

		public double Protein { get; set; }

		public string Description { get; set; }

		public byte[]? Image { get; set; }
	}
}
