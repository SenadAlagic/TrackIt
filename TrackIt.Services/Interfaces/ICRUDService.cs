namespace TrackIt.Services.Interfaces
{
	public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IService<T, TSearch> where T : class where TSearch : class
	{
		Task<T> Insert(TInsert insert);
		Task<T> Update(int id, TUpdate update);
		Task<T> Delete(int id);
	}
}
