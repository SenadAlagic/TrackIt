namespace TrackIt.Model.Models
{
    public class Preference
    {
        public int PreferenceId { get; set; }

        public string? Name { get; set; }

        public virtual ICollection<UsersPreference> UsersPreferences { get; set; } = new List<UsersPreference>();
    }
}
