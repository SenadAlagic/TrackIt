using Microsoft.AspNetCore.Mvc;
using TrackIt.Model;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
    [ApiController]
	[Route("[controller]")]
	public class MealController : ControllerBase
	{
		private readonly IMealsService _mealsService;
		private readonly ILogger<MealController> _logger;

		public MealController(ILogger<MealController> logger, IMealsService mealsService)
		{
			_mealsService = mealsService;
			_logger = logger;
		}

		[HttpGet()]
		public IEnumerable<Meal> Get()
		{
			return _mealsService.Get();
		}

	}
}