using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class IngredientService : BaseCRUDService<Model.Models.Ingredient, Database.Ingredient, IngredientSearchObject, IngredientInsertRequest, IngredientUpdateRequest>, IIngredientService
	{
		TrackItContext _context;

		public IngredientService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
			_context = context;
		}

		public override IQueryable<Ingredient> AddFilter(IQueryable<Ingredient> query, IngredientSearchObject? search = null)
		{
			if (search?.Name.IsNullOrEmpty() == false)
			{
				query = query.Where(ingredient => ingredient.Name.ToLower().Contains(search.Name.ToLower()));
			}

			if (search?.MaxCarbs > 0)
			{
				query = query.Where(ingredient => ingredient.Carbs < search.MaxCarbs);
			}
			if (search?.MaxProtein > 0)
			{
				query = query.Where(ingredient => ingredient.Protein < search.MaxProtein);
			}
			if (search?.MaxCalories > 0)
			{
				query = query.Where(ingredient => ingredient.Calories < search.MaxCalories);
			}
			if (search?.MaxFat > 0)
			{
				query = query.Where(ingredient => ingredient.Fat < search.MaxFat);
			}

			if (search?.MinCarbs > 0)
			{
				query = query.Where(ingredient => ingredient.Carbs > search.MinCarbs);
			}
			if (search?.MinProtein > 0)
			{
				query = query.Where(ingredient => ingredient.Protein > search.MinProtein);
			}
			if (search?.MinCalories > 0)
			{
				query = query.Where(ingredient => ingredient.Calories > search.MinCalories);
			}
			if (search?.MinFat > 0)
			{
				query = query.Where(ingredient => ingredient.Fat > search.MinFat);
			}
			return base.AddFilter(query, search);
		}

		public async Task<int> GetNumberOfItems()
		{
			return await _context.Ingredients.CountAsync();
		}
	}
}
