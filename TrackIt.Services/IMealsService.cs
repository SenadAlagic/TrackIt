using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackIt.Model;

namespace TrackIt.Services
{
	public interface IMealsService
	{
		IList<Meal> Get();
	}
}
