namespace TrackIt.Services.Database;

public partial class TagsMeal
{
	public int TagMealId { get; set; }

	public int TagId { get; set; }

	public int MealId { get; set; }

	public virtual Meal Meal { get; set; } = null!;

	public virtual Tag Tag { get; set; } = null!;
}
