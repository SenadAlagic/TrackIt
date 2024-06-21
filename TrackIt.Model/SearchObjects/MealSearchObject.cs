namespace TrackIt.Model.SearchObjects
{
	public class MealSearchObject : BaseSearchObject
	{
		public string? Name { get; set; }

		public int[]? IngredientIds { get; set; }

		public string[]? Preferences { get; set; }

		public bool IsIngredientsIncluded { get; set; }

		public bool IsTagsIncluded { get; set; }

	}
}