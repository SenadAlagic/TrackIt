﻿namespace TrackIt.Model.Models
{
    public class WeightOverTime
    {
        public int LogId { get; set; }

        public int UserId { get; set; }

        public double? Weight { get; set; }

        public DateTime? DateLogged { get; set; }

        public string? Comment { get; set; }

        public virtual GeneralUser User { get; set; } = null!;
    }
}
