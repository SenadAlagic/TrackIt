using Microsoft.AspNetCore.Mvc;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Interfaces;

namespace TrackIt.Controllers
{
	[ApiController]
	public class UserMealController : BaseCRUDController<UsersMeal, UsersMealsSearchObject, UsersMealsInsertRequest, UsersMealsUpdateRequest>
	{
		public UserMealController(ILogger<BaseController<UsersMeal, UsersMealsSearchObject>> logger, IUsersMealsService service) : base(logger, service)
		{
		}
	}
}