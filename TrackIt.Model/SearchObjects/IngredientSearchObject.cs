namespace TrackIt.Model.SearchObjects
{
	public class IngredientSearchObject : BaseSearchObject
	{
		public string? Name { get; set; }

		public double? Protein { get; set; }

		public double? Fat { get; set; }

		public double? Carbs { get; set; }

		public double? Calories { get; set; }
	}
}
