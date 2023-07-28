using System;
using System.Collections.Generic;

namespace TrackIt.Services.Database;

public partial class Tag
{
    public int TagId { get; set; }

    public string? Name { get; set; }

    public string? Description { get; set; }

    public string? Color { get; set; }

    public virtual ICollection<TagsMeal> TagsMeals { get; set; } = new List<TagsMeal>();
}
