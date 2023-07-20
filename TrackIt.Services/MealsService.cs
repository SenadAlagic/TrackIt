using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackIt.Model;

namespace TrackIt.Services
{
	public class MealsService : IMealsService
	{
		List<Meal> meals = new List<Meal>()
		{
			new Meal()
			{
				MealID=1,
				Name="Burger",
			}
		};

		public IList<Meal> Get()
		{
			return meals;
		}
	}
}
