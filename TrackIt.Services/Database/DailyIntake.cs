namespace TrackIt.Services.Database;

public partial class DailyIntake
{
	public int DailyIntakeId { get; set; }

	public int UserId { get; set; }

	public DateTime? Day { get; set; }

	public double? Calories { get; set; }

	public double? Carbs { get; set; }

	public double? Protein { get; set; }

	public double? Fat { get; set; }

	public double? Fiber { get; set; }

	public virtual GeneralUser User { get; set; } = null!;
}
