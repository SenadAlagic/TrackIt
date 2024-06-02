namespace TrackIt.Model.Helper
{
	public class PagedResult<T>
	{
		public List<T> Result { get; set; } = new List<T>();
		public Meta Meta { get; set; }

		private PagedResult(List<T> items, int count, int pageNumber, int pageSize)
		{
			this.Meta = new Meta(count, pageNumber, pageSize);
			this.Result.AddRange(items);
		}

		public static PagedResult<T> Create(List<T> items, int pageNumber, int pageSize, int totalCount)
		{
			return new PagedResult<T>(items, totalCount, pageNumber, pageSize);
		}
	}
}
