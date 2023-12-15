﻿namespace TrackIt.Model.Models
{
    public class UsersGoal
    {
        public int UsersGoalsId { get; set; }

        public int? UserId { get; set; }

        public int? GoalId { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public virtual Goal? Goal { get; set; }
    }
}