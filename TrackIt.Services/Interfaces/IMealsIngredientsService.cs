﻿using TrackIt.Model.Helper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;

namespace TrackIt.Services.Interfaces
{
	public interface IMealsIngredientsService : ICRUDService<MealsIngredient, MealsIngredientsSearchObject, MealsIngredientsInsertRequest, MealsIngredientsUpdateRequest>
	{
		Task<MealsIngredient> Remove(IngredientData ingredientData);
	}
}
