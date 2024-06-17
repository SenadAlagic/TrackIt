using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class DailyIntakeService : BaseCRUDService<Model.Models.DailyIntake, Database.DailyIntake, DailyIntakeSearchObject, DailyIntakeInsertRequest, DailyIntakeUpdateRequest>, IDailyIntakeService
	{
		public DailyIntakeService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{

		}

		public override Task BeforeInsert(DailyIntake entity, DailyIntakeInsertRequest insert)
		{
			entity.Day = DateTime.Today;
			return base.BeforeInsert(entity, insert);
		}

		public void UpdateOnLogging(int userId, Meal meal, int servings)
		{
			var set = _context.Set<DailyIntake>();

			var existingEntry = set.FirstOrDefault(di => di.UserId == userId && di.Day.Value.Date == DateTime.Now.Date);
			if (existingEntry != null)
			{
				existingEntry.Protein += meal.Protein * servings;
				existingEntry.Fat += meal.Fat * servings;
				existingEntry.Carbs += meal.Carbs * servings;
				existingEntry.Calories += meal.Calories * servings;
				//existingEntry.Fiber+= meal.Fiber * servings; TODO
			}
			else
			{
				var newEntry = new DailyIntake()
				{
					UserId = userId,
					Calories = meal.Calories * servings,
					Carbs = meal.Carbs * servings,
					Fat = meal.Fat * servings,
					Protein = meal.Protein * servings,
					Day = DateTime.Now
				};
				set.Add(newEntry);
			}
			_context.SaveChanges();
			return;
		}

		public override async Task<Model.Models.DailyIntake> Update(int id, DailyIntakeUpdateRequest update)
		{
			var set = _context.Set<DailyIntake>();
			var entity = set.Where(di => di.Day == DateTime.Today).FirstOrDefault();
			if (entity == null)
			{
				var insertEntity = _mapper.Map<DailyIntakeInsertRequest>(update);
				return await base.Insert(insertEntity);
			};
			entity.Calories += update.Meal.Calories * update.Quantity;
			entity.Carbs += update.Meal.Carbs * update.Quantity;
			entity.Fat += update.Meal.Fat * update.Quantity;
			entity.Protein += update.Meal.Protein * update.Quantity;
			//entity.Fiber+= update.Meal.Fiber; TODO
			return await base.Update(id, update);
		}
		public override IQueryable<DailyIntake> AddFilter(IQueryable<DailyIntake> query, DailyIntakeSearchObject? search = null)
		{
			if (search?.UserId != 0)
			{
				query = query.Where(di => di.UserId == search.UserId && di.Day == DateTime.Today);
			}
			return base.AddFilter(query, search);
		}
	}
}
