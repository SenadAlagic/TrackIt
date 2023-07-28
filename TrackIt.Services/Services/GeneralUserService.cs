using AutoMapper;
using System.Security.Cryptography;
using System.Text;
using TrackIt.Model.Requests;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class GeneralUserService : IGeneralUserService
	{
		private TrackItContext _context;
		public IMapper _mapper { get; set; }

		public GeneralUserService(TrackItContext context, IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
		}

		public List<Model.GeneralUser> Get()
		{
			var entityList = _context.GeneralUsers.ToList();
			return _mapper.Map<List<Model.GeneralUser>>(entityList);
		}

		public Model.GeneralUser Insert(GeneralUserInsertRequest request)
		{
			var user = new User();
			_mapper.Map(request, user);
			user.Salt = GenerateSalt();
			user.Password = GenerateHash(user.Salt, request.Password);
			_context.Users.Add(user);

			var generalUser = new GeneralUser();
			_mapper.Map(request, generalUser);
			generalUser.User = user;
			_context.GeneralUsers.Add(generalUser);

			_context.SaveChanges();

			return _mapper.Map<Model.GeneralUser>(generalUser);
		}

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
	}
}
