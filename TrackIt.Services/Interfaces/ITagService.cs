using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface ITagService : ICRUDService<Model.Models.Tag, TagSearchObject, TagInsertRequest, TagUpdateRequest>
	{
		Task<int> GetNumberOfItems();
	}
}
