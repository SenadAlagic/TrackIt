using AutoMapper;
using TrackIt.Model.Requests;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;

namespace TrackIt.Services.Services
{
	public class UserService : IUserService
	{
		private readonly TrackItContext _context;
		public IMapper _mapper { get; set; }

		public UserService(TrackItContext context, IMapper mapper)
		{
			_context = context;
			_mapper = mapper;
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
	}
}
