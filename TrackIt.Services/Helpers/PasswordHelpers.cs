using System.Security.Cryptography;
using System.Text;

namespace TrackIt.Services.Helper
{
	public static class PasswordHelpers
	{
		public static string GenerateSalt()
		{
			RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
			var byteArray = new byte[16];
			provider.GetBytes(byteArray);

			return Convert.ToBase64String(byteArray);
		}

		public static string GenerateHash(string salt, string password)
		{
			byte[] src = Convert.FromBase64String(salt);
			byte[] bytes = Encoding.Unicode.GetBytes(password);
			byte[] dst = new byte[src.Length + bytes.Length];

			Buffer.BlockCopy(src, 0, dst, 0, src.Length);
			Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

			HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
			byte[] inArray = algorithm.ComputeHash(dst);
			return Convert.ToBase64String(inArray);
		}

		public static bool VerifyPassword(string enteredPassword, string storedPasswordHash, string storedSalt)
		{
			string enteredPasswordHash = GenerateHash(storedSalt, enteredPassword);
			return enteredPasswordHash == storedPasswordHash;
		}
	}
}
