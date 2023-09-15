using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class GeneralUserService : BaseCRUDService<Model.Models.GeneralUser, Database.GeneralUser, GeneralUserSearchObject, GeneralUserInsertRequest, GeneralUserUpdateRequest>, IGeneralUserService
	{
		public GeneralUserService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override async Task BeforeInsert(GeneralUser entity, GeneralUserInsertRequest insert)
		{
			User user = _mapper.Map<User>(insert);
			entity.User = user;
			entity.User.Salt = GenerateSalt();
			entity.User.Password = GenerateHash(entity.User.Salt, insert.Password);
		}

		public override IQueryable<GeneralUser> AddInclude(IQueryable<GeneralUser> query, GeneralUserSearchObject? search = null)
		{
			if (search?.IsUserIncluded == true)
			{
				query = query.Include("User");
			}
			if (search?.IsActivityLevelIncluded == true)
			{
				query = query.Include("ActivityLevel");
			}
			if (search?.IsGoalIncluded == true)
			{
				query = query.Include("UsersGoals.Goal");
			}
			return base.AddInclude(query, search);
		}

		public override IQueryable<GeneralUser> AddFilter(IQueryable<GeneralUser> query, GeneralUserSearchObject? search = null)
		{
			if (search.Weight > 0)
			{
				query = query.Where(x => x.Weight == search.Weight);
			}
			if (search.TargetWeight > 0)
			{
				query = query.Where(x => x.TargetWeight == search.TargetWeight);
			}
			if (search.Height > 0)
			{
				query = query.Where(x => x.Height == search.Height);
			}
			return base.AddFilter(query, search);
		}

		public override async Task<Model.Models.GeneralUser> Update(int id, GeneralUserUpdateRequest update)
		{
			var set = _context.Set<GeneralUser>();
			var entity = await set.Include(g => g.User).FirstOrDefaultAsync(g => g.GeneralUserId == id);
			_mapper.Map(update, entity?.User);
			_mapper.Map(update, entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.GeneralUser>(entity);
		}

		public async Task<Model.Models.GeneralUser> UpdateBaseUser(int id, UserUpdateRequest update)
		{
			var set = _context.Set<GeneralUser>();
			var entity = await set.Include(g => g.User).FirstOrDefaultAsync(g => g.GeneralUserId == id);
			_mapper.Map(update, entity?.User);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.GeneralUser>(entity);
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
