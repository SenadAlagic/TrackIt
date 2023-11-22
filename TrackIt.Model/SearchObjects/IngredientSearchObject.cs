namespace TrackIt.Model.SearchObjects
{
	public class IngredientSearchObject : BaseSearchObject
	{
		public string? Name { get; set; }

		public double? MinProtein { get; set; }

		public double? MaxProtein { get; set; }

		public double? MinFat { get; set; }

		public double? MaxFat { get; set; }

		public double? MinCarbs { get; set; }

		public double? MaxCarbs { get; set; }

		public double? MinCalories { get; set; }

		public double? MaxCalories { get; set; }
	}
}
