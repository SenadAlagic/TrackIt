using AutoMapper;

namespace TrackIt.Services
{
	public class MappingProfile : Profile
	{
		public MappingProfile()
		{
			CreateMap<Database.User, Model.User>();
			CreateMap<Model.Requests.UserUpdateRequest, Database.User>();

			CreateMap<Database.GeneralUser, Model.GeneralUser>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.User>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.GeneralUser>();

			CreateMap<Database.Meal, Model.Meal>();
			CreateMap<Model.Requests.MealInsertRequest, Database.Meal>();
			CreateMap<Model.Requests.MealUpdateRequest, Database.Meal>();
		}
	}
}
