namespace TrackIt.Model.Requests
{
	public class MealsIngredientsInsertRequest
	{
		public int MealId { get; set; }
		public int IngredientId { get; set; }
		public int IngredientQuantity { get; set; }

	}
}
