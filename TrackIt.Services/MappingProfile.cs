using AutoMapper;
using TrackIt.Model.Models;

namespace TrackIt.Services
{
	public class MappingProfile : Profile
	{
		public MappingProfile()
		{
			CreateMap<int?, int>().ConvertUsing((src, dest) => src ?? dest);
			CreateMap<string?, string>().ConvertUsing((src, dest) => src ?? dest);

			CreateMap<Database.ActivityLevel, ActivityLevel>();

			CreateMap<Database.Admin, Admin>();

			CreateMap<Database.DailyIntake, DailyIntake>();

			CreateMap<Database.GeneralUser, GeneralUser>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.User>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.GeneralUser>();
			CreateMap<Model.Requests.GeneralUserUpdateRequest, Database.User>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
			CreateMap<Model.Requests.GeneralUserUpdateRequest, Database.GeneralUser>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

			CreateMap<Database.Goal, Goal>();
			CreateMap<Model.Requests.GoalInsertRequest, Database.Goal>();
			CreateMap<Model.Requests.GoalUpdateRequest, Database.Goal>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

			CreateMap<Database.Ingredient, Ingredient>();
			CreateMap<Model.Requests.IngredientInsertRequest, Database.Ingredient>();
			CreateMap<Model.Requests.IngredientUpdateRequest, Database.Ingredient>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.Meal, Meal>();
			CreateMap<Model.Requests.MealInsertRequest, Database.Meal>();
			CreateMap<Model.Requests.MealUpdateRequest, Database.Meal>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.MealsIngredient, MealsIngredient>();

			CreateMap<Database.Preference, Preference>();

			CreateMap<Database.Tag, Tag>();
			CreateMap<Model.Requests.TagInsertRequest, Database.Tag>();
			CreateMap<Model.Requests.TagUpdateRequest, Database.Tag>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.TagsMeal, TagsMeal>();

			CreateMap<Database.User, User>();
			CreateMap<Model.Requests.UserUpdateRequest, Database.User>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.UsersGoal, UsersGoal>();

			CreateMap<Database.UsersMeal, UsersMeal>();

			CreateMap<Database.UsersPreference, UsersPreference>();

			CreateMap<Database.WeightOverTime, WeightOverTime>();
		}
	}
}
