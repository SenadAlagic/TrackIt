namespace TrackIt.Model.SearchObjects
{
	public class MealSearchObject : BaseSearchObject
	{
		public int? MealId { get; set; }

		public string? Name { get; set; }

		public int[]? IngredientIds { get; set; }

		public bool IsIngredientsIncluded { get; set; }

		public bool IsTagsIncluded { get; set; }

	}
}