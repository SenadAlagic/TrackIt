using AutoMapper;

namespace TrackIt.Services
{
	public class MappingProfile : Profile
	{
		public MappingProfile()
		{
			CreateMap<Database.User, Model.User>();
			CreateMap<Database.GeneralUser, Model.GeneralUser>();
			CreateMap<Database.Meal, Model.Meal>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.User>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.GeneralUser>();
			CreateMap<Model.Requests.UserUpdateRequest, Database.User>();
		}
	}
}
