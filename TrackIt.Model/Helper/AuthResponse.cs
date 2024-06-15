namespace TrackIt.Model.Helper
{
	public class AuthResponse
	{
		public AuthResult Result { get; set; }
		public string Token { get; set; }
		public int UserId { get; set; }
		public int RoleId { get; set; }
	}
}
