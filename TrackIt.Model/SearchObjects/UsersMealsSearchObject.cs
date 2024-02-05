namespace TrackIt.Model.SearchObjects
{
	public class UsersMealsSearchObject : BaseSearchObject
	{
		public int MealId { get; set; }
		public int UserId { get; set; }
		public bool isUserIncluded { get; set; }
		public bool isMealIncluded { get; set; }
	}
}
