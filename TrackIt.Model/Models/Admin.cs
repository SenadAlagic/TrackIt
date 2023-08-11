namespace TrackIt.Model.Models
{
    public class Admin
    {
        public int AdminId { get; set; }

        public int UserId { get; set; }

        public virtual User User { get; set; } = null!;
    }
}
