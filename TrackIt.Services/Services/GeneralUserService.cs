﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Helper;
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
			entity.User.Salt = PasswordHelpers.GenerateSalt();
			entity.User.Password = PasswordHelpers.GenerateHash(entity.User.Salt, insert.Password);
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
			if (search?.Weight > 0)
			{
				query = query.Where(x => x.Weight == search.Weight);
			}
			if (search?.TargetWeight > 0)
			{
				query = query.Where(x => x.TargetWeight == search.TargetWeight);
			}
			if (search?.Height > 0)
			{
				query = query.Where(x => x.Height == search.Height);
			}
			if (search?.FirstName.IsNullOrEmpty() == false)
			{
				query = query.Where(user => user.User.FirstName.ToLower().Contains(search.FirstName.ToLower()));
			}
			if (search?.LastName.IsNullOrEmpty() == false)
			{
				query = query.Where(user => user.User.LastName.ToLower().Contains(search.LastName.ToLower()));
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
	}
}
