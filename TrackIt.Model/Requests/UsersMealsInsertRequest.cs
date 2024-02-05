namespace TrackIt.Model.Requests
{
	public class UsersMealsInsertRequest
	{
		public int UserId { get; set; }
		public int MealId { get; set; }
		public DateTime DateConsumed { get; set; }
		public int Servings { get; set; }
	}
}
