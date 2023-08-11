namespace TrackIt.Model.Models
{
    public class Goal
    {
        public int GoalId { get; set; }

        public string? Name { get; set; }

        public string? Description { get; set; }

        public double? TargetProtein { get; set; }

        public int? TargetCalories { get; set; }
    }
}
