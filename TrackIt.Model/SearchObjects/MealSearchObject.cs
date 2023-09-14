namespace TrackIt.Model.SearchObjects
{
	public class MealSearchObject : BaseSearchObject
	{
		public string? MealId { get; set; }
		public string? Name { get; set; }
		public int[]? IngredientIds { get; set; }
	}
}
