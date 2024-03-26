namespace TrackIt.Services.Database;

public partial class Meal
{
	public int MealId { get; set; }

	public double? Fat { get; set; }

	public double? Calories { get; set; }

	public double? Carbs { get; set; }

	public double? Protein { get; set; }

	public string? Name { get; set; }

	public string? Description { get; set; }

	public byte[]? Image { get; set; }

	public virtual ICollection<MealsIngredient> MealsIngredients { get; set; } = new List<MealsIngredient>();

	public virtual ICollection<TagsMeal> TagsMeals { get; set; } = new List<TagsMeal>();

	public virtual ICollection<UsersMeal> UsersMeals { get; set; } = new List<UsersMeal>();
}
