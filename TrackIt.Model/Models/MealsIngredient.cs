namespace TrackIt.Model.Models
{
    public class MealsIngredient
    {
        public int MealIngredientsId { get; set; }

        public int MealId { get; set; }

        public int IngredientId { get; set; }

        public int? IngredientQuantity { get; set; }

        public virtual Ingredient Ingredient { get; set; } = null!;

        public virtual Meal Meal { get; set; } = null!;
    }
}
