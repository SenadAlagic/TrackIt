using System;
using System.Collections.Generic;

namespace TrackIt.Services.Database;

public partial class UsersMeal
{
    public int UsersMealsId { get; set; }

    public int UserId { get; set; }

    public int MealId { get; set; }

    public DateTime? DateConsumed { get; set; }

    public int? Servings { get; set; }

    public virtual Meal Meal { get; set; } = null!;

    public virtual GeneralUser User { get; set; } = null!;
}
