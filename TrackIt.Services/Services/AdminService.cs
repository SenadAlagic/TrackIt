using AutoMapper;
using Microsoft.EntityFrameworkCore;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Helper;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class AdminService : BaseCRUDService<Model.Models.Admin, Admin, AdminSearchObject, AdminInsertRequest, AdminUpdateRequest>, IAdminService
	{
		public AdminService(TrackItContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override async Task BeforeInsert(Admin entity, AdminInsertRequest insert)
		{
			User user = _mapper.Map<User>(insert);
			entity.User = user;
			entity.User.Salt = PasswordHelpers.GenerateSalt();
			entity.User.Password = PasswordHelpers.GenerateHash(entity.User.Salt, insert.Password);
		}

		public override IQueryable<Admin> AddInclude(IQueryable<Admin> query, AdminSearchObject? search = null)
		{
			if (search.isUserIncluded == true)
			{
				query = query.Include("User");
			}
			return base.AddInclude(query, search);
		}

		public override async Task<Model.Models.Admin> Update(int id, AdminUpdateRequest update)
		{
			var set = _context.Set<Admin>();
			var entity = await set.Include(a => a.User).FirstOrDefaultAsync(a => a.AdminId == id);
			_mapper.Map(update, entity?.User);
			_mapper.Map(update, entity);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.Admin>(entity);
		}

		public async Task<Model.Models.Admin> UpdateBaseUser(int id, AdminUpdateRequest update)
		{
			var set = _context.Set<Admin>();
			var entity = await set.Include(a => a.User).FirstOrDefaultAsync(a => a.AdminId == id);
			_mapper.Map(update, entity?.User);
			await _context.SaveChangesAsync();
			return _mapper.Map<Model.Models.Admin>(entity);
		}
	}
}
