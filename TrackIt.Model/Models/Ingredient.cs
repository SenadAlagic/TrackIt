namespace TrackIt.Model.Models
{
    public class Ingredient
    {
        public int IngredientId { get; set; }

        public string? Name { get; set; }

        public double? Protein { get; set; }

        public double? Fat { get; set; }

        public double? Carbs { get; set; }

        public double? Calories { get; set; }

        public virtual ICollection<MealsIngredient> MealsIngredients { get; set; } = new List<MealsIngredient>();
    }
}
