using System;
using System.Collections.Generic;

namespace TrackIt.Services.Database;

public partial class ActivityLevel
{
    public int ActivityLevelId { get; set; }

    public string Name { get; set; } = null!;

    public double Multiplier { get; set; }

    public byte[]? Image { get; set; }

    public virtual ICollection<GeneralUser> GeneralUsers { get; set; } = new List<GeneralUser>();
}
