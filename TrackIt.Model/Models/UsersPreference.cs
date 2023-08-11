namespace TrackIt.Model.Models
{
    public class UsersPreference
    {
        public int UserPreferenceId { get; set; }

        public int? UserId { get; set; }

        public int? PreferenceId { get; set; }

        public virtual Preference? Preference { get; set; }

        public virtual GeneralUser? User { get; set; }
    }
}
