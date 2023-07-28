using System;
using System.Collections.Generic;

namespace TrackIt.Services.Database;

public partial class GeneralUser
{
    public int GeneralUserId { get; set; }

    public int UserId { get; set; }

    public string? Gender { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public double? Height { get; set; }

    public double? Weight { get; set; }

    public double? TargetWeight { get; set; }

    public int ActivityLevelId { get; set; }

    public virtual ActivityLevel ActivityLevel { get; set; } = null!;

    public virtual ICollection<DailyIntake> DailyIntakes { get; set; } = new List<DailyIntake>();

    public virtual User User { get; set; } = null!;

    public virtual ICollection<UsersGoal> UsersGoals { get; set; } = new List<UsersGoal>();

    public virtual ICollection<UsersMeal> UsersMeals { get; set; } = new List<UsersMeal>();

    public virtual ICollection<UsersPreference> UsersPreferences { get; set; } = new List<UsersPreference>();

    public virtual ICollection<WeightOverTime> WeightOverTimes { get; set; } = new List<WeightOverTime>();
}
