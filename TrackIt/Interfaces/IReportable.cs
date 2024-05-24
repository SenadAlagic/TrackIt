namespace TrackIt.Interfaces
{
	public interface IReportable
	{
		Task<int> GetNumberOfItems();
	}
}
