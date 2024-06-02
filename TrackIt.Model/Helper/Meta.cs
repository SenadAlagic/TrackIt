namespace TrackIt.Model.Helper
{
	public class Meta
	{
		public int? Count { get; set; }
		public int CurrentPage { get; }
		public int TotalPages { get; }
		public bool HasPrevious => CurrentPage > 0;
		public bool HasNext => CurrentPage < TotalPages - 1;
		public Meta(int count, int pageNumber, int pageSize)
		{
			CurrentPage = pageNumber;
			Count = count;
			TotalPages = (int)Math.Ceiling(count / (double)pageSize);
		}
	}
}
