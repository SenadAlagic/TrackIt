namespace TrackIt.Model.Models
{
	public class TagsMeal
	{
		public int TagMealId { get; set; }

		public int TagId { get; set; }

		public int MealId { get; set; }

		/// <summary>
		/// commented out in order to avoid the cyclic behavior when the many to many relationship is included 
		/// </summary>
		//public virtual Meal Meal { get; set; } = null!;

		public virtual Tag Tag { get; set; } = null!;
	}
}
