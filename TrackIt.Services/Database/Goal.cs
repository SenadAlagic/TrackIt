using System;
using System.Collections.Generic;

namespace TrackIt.Services.Database;

public partial class Goal
{
    public int GoalId { get; set; }

    public string? Name { get; set; }

    public string? Description { get; set; }

    public double? TargetProtein { get; set; }

    public int? TargetCalories { get; set; }

    public virtual ICollection<UsersGoal> UsersGoals { get; set; } = new List<UsersGoal>();
}
