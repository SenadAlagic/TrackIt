using AutoMapper;
using TrackIt.Model.Models;
using TrackIt.Model.Requests;

namespace TrackIt.Services
{
	public class MappingProfile : Profile
	{
		public MappingProfile()
		{
			CreateMap<int?, int>().ConvertUsing((src, dest) => src ?? dest);
			CreateMap<string?, string>().ConvertUsing((src, dest) => src ?? dest);
			CreateMap<double?, double>().ConvertUsing((src, dest) => src ?? dest);

			CreateMap<Database.ActivityLevel, ActivityLevel>();
			CreateMap<Model.Requests.ActivityLevelInsertRequest, Database.ActivityLevel>();
			CreateMap<Model.Requests.ActivityLevelUpdateRequest, Database.ActivityLevel>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

			CreateMap<Database.Admin, Admin>();
			CreateMap<Model.Requests.AdminInsertRequest, Database.User>();
			CreateMap<Model.Requests.AdminInsertRequest, Database.Admin>();
			CreateMap<Model.Requests.AdminUpdateRequest, Database.User>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
			CreateMap<Model.Requests.AdminUpdateRequest, Database.Admin>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));


			CreateMap<Database.DailyIntake, DailyIntake>();
			CreateMap<Model.Requests.DailyIntakeInsertRequest, Database.DailyIntake>();
			CreateMap<Model.Requests.DailyIntakeUpdateRequest, Database.DailyIntake>();
			CreateMap<Model.Requests.DailyIntakeUpdateRequest, Model.Requests.DailyIntakeInsertRequest>()
			.ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
			.ForMember(dest => dest.Calories, opt => opt.MapFrom(src => src.Meal.Calories))
			.ForMember(dest => dest.Carbs, opt => opt.MapFrom(src => src.Meal.Carbs))
			.ForMember(dest => dest.Protein, opt => opt.MapFrom(src => src.Meal.Protein))
			.ForMember(dest => dest.Fat, opt => opt.MapFrom(src => src.Meal.Fat));
			//.ForMember(dest => dest.Fiber, opt => opt.MapFrom(src => src.Meal.Fiber)); TODO add fiber

			CreateMap<Database.GeneralUser, GeneralUser>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.User>();
			CreateMap<Model.Requests.GeneralUserInsertRequest, Database.GeneralUser>();
			CreateMap<Model.Requests.GeneralUserUpdateRequest, Database.User>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));
			CreateMap<Model.Requests.GeneralUserUpdateRequest, Database.GeneralUser>().ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

			CreateMap<Database.Goal, Goal>();
			CreateMap<Model.Requests.GoalInsertRequest, Database.Goal>();
			CreateMap<Model.Requests.GoalUpdateRequest, Database.Goal>();//.ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null));

			CreateMap<Database.Ingredient, Ingredient>();
			CreateMap<Model.Requests.IngredientInsertRequest, Database.Ingredient>();
			CreateMap<Model.Requests.IngredientUpdateRequest, Database.Ingredient>();//.ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.Meal, Meal>();
			CreateMap<Model.Requests.MealInsertRequest, Database.Meal>();
			CreateMap<Model.Requests.MealUpdateRequest, Database.Meal>();//.ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.MealsIngredient, MealsIngredient>();
			CreateMap<MealsIngredientsInsertRequest, Database.MealsIngredient>();
			CreateMap<MealsIngredientsUpdateRequest, Database.MealsIngredient>();

			CreateMap<Database.Preference, Preference>();

			CreateMap<Database.Subscription, Subscription>();
			CreateMap<Model.Requests.SubscriptionInsertRequest, Database.Subscription>();
			CreateMap<Model.Requests.SubscriptionUpdateRequest, Database.Subscription>();

			CreateMap<Database.Tag, Tag>();
			CreateMap<Model.Requests.TagInsertRequest, Database.Tag>();
			CreateMap<Model.Requests.TagUpdateRequest, Database.Tag>();//.ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.TagsMeal, TagsMeal>();

			CreateMap<Database.User, User>();
			CreateMap<Model.Requests.UserUpdateRequest, Database.User>();//.ForAllMembers(opts => opts.Condition((src, dest, srcMember) => srcMember != null)); ;

			CreateMap<Database.UsersGoal, UsersGoal>();

			CreateMap<Database.UsersMeal, UsersMeal>();
			CreateMap<Model.Requests.UsersMealsInsertRequest, Database.UsersMeal>();
			CreateMap<Model.Requests.UsersMealsUpdateRequest, Database.UsersMeal>();

			CreateMap<Database.UsersPreference, UsersPreference>();
			CreateMap<Model.Requests.UsersPreferencesInsertRequest, Database.UsersPreference>();
			CreateMap<Model.Requests.UsersPreferencesUpdateRequest, Database.UsersPreference>();

			CreateMap<Database.WeightOverTime, WeightOverTime>();
			CreateMap<Model.Requests.WeightOverTimeInsertRequest, Database.WeightOverTime>();
			CreateMap<Model.Requests.WeightOverTimeUpdateRequest, Database.WeightOverTime>();
		}
	}
}
