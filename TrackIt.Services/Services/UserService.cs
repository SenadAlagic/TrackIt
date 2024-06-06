using AutoMapper;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using TrackIt.Model.Helper;
using TrackIt.Model.Requests;
using TrackIt.Model.SearchObjects;
using TrackIt.Services.Database;
using TrackIt.Services.Helper;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class UserService : BaseCRUDService<Model.Models.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
	{
		private readonly TrackItContext _context;
		public IMapper _mapper { get; set; }
		private readonly IConfiguration _config;

		public UserService(TrackItContext context, IMapper mapper, IConfiguration configuration) : base(context, mapper)
		{
			_context = context;
			_mapper = mapper;
			_config = configuration;
		}

		public List<Model.Models.User> Get()
		{
			var entityList = _context.Users.ToList();
			return _mapper.Map<List<Model.Models.User>>(entityList);
		}

		public Model.Models.User Update(int Id, UserUpdateRequest request)
		{
			var entity = _context.Users.Find(Id);
			_mapper.Map(request, entity);
			_context.SaveChanges();
			return _mapper.Map<Model.Models.User>(entity);
		}

		public async Task<AuthResponse> AuthenticateUser(string email, string password, string role)
		{
			var user = _context.Users.FirstOrDefault(u => u.Email == email);

			if (user == null)
			{
				return new AuthResponse { Result = AuthResult.UserNotFound };
			}

			if (!PasswordHelpers.VerifyPassword(password, user.Password, user.Salt))
			{
				return new AuthResponse { Result = AuthResult.InvalidPassword };
			}

			var token = CreateToken(user, role);
			if (token == null)
			{
				return new AuthResponse { Result = AuthResult.UserNotFound };
			}
			return new AuthResponse { Result = AuthResult.Success, UserId = user.UserId, Token = token };
		}

		private string CreateToken(User user, string desiredRole)
		{
			var adminList = _context.Admins.FirstOrDefault(a => a.UserId == user.UserId);
			var role = "generalUser";
			if (adminList != null && desiredRole == "admin")
			{
				role = "admin";
			}
			else if ((adminList != null && desiredRole == "generalUser") || (adminList == null && desiredRole == "admin"))
			{
				return null;
			}

			List<Claim> claims = new List<Claim>
			{
				new Claim(ClaimTypes.Email, user.Email),
				new Claim(ClaimTypes.Role, role)
			};
			var key = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(_config.GetSection("AppSettings:Token").Value));
			var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
			var token = new JwtSecurityToken(
				claims: claims,
				expires: DateTime.Now.AddDays(1),
				signingCredentials: creds
				);

			var jwt = new JwtSecurityTokenHandler().WriteToken(token);

			return jwt;
		}
	}
}
