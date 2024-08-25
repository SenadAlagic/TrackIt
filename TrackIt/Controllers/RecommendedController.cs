using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class RecommendedResultController : BaseCRUDController<RecommendedResult, RecommendedResultSearchObject, RecommendedResultInsertRequest, RecommendedResultUpdateRequest>
	{
		IRecommendedResultService _service;
		public RecommendedResultController(ILogger<BaseController<RecommendedResult, RecommendedResultSearchObject>> logger, IRecommendedResultService service) : base(logger, service)
		{
			_service = service;
		}

		[Authorize(Roles = "admin")]
		[HttpDelete("/deleteRecommendations")]
		public async Task DeleteRecommendations()
		{
			await _service.DeleteAllRecommendation();
		}

		[Authorize]
		[HttpGet("/recommendMeal/{id}")]

		public async Task<Meal> RecommendMeal(int id)
		{
			return await _service.Recommend(id);
		}
	}
}