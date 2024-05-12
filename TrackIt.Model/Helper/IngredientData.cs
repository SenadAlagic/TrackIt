namespace TrackIt.Model.Helper
{
	public class IngredientData
	{
		public int IngredientId { get; set; }

		public int Quantity { get; set; } = 0;

		public int? MealId { get; set; }
	}
}
