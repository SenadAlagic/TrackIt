namespace TrackIt.Services.Database;

public partial class User
{
	public int UserId { get; set; }

	public string? FirstName { get; set; }

	public string? LastName { get; set; }

	public string? Email { get; set; }

	public string? Username { get; set; }

	public string? Password { get; set; }

	public string? Salt { get; set; }

	public virtual ICollection<Admin> Admins { get; set; } = new List<Admin>();

	public virtual ICollection<GeneralUser> GeneralUsers { get; set; } = new List<GeneralUser>();
}
