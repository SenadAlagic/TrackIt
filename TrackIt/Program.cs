using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using TrackIt.Filters;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;
using TrackIt.Services.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IActivityLevelService, ActivityLevelService>();
builder.Services.AddTransient<IMealsService, MealsService>();
builder.Services.AddTransient<IGoalService, GoalsService>();
builder.Services.AddTransient<ITagService, TagService>();
builder.Services.AddTransient<IIngredientService, IngredientService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IUsersMealsService, UsersMealsService>();
builder.Services.AddTransient<IGeneralUserService, GeneralUserService>();
builder.Services.AddTransient<IAdminService, AdminService>();
builder.Services.AddTransient<IDailyIntakeService, DailyIntakeService>();
builder.Services.AddTransient<IUsersPreferenceService, UsersPreferencesService>();
builder.Services.AddTransient<IPreferenceService, PreferenceService>();
builder.Services.AddTransient<IMealsIngredientsService, MealsIngredientsService>();
builder.Services.AddTransient<IWeightOverTimeService, WeightOverTimeService>();


builder.Services.AddAuthentication(
	JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
	{
		options.TokenValidationParameters = new TokenValidationParameters
		{
			ValidateIssuerSigningKey = true,
			IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration.GetSection("AppSettings:Token").Value)),
			ValidateIssuer = false,
			ValidateAudience = false
		};
	});

builder.Services.AddControllers(x =>
{
	x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
	c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
	{
		In = ParameterLocation.Header,
		Name = "Authorization",
		Type = SecuritySchemeType.ApiKey,
		Scheme = "Bearer"
	});
	c.AddSecurityRequirement(new OpenApiSecurityRequirement()
	  {
		{
		  new OpenApiSecurityScheme
		  {
			Reference = new OpenApiReference
			  {
				Type = ReferenceType.SecurityScheme,
				Id = "Bearer"
			  },
			  Scheme = "oauth2",
			  Name = "Bearer",
			  In = ParameterLocation.Header,

			},
			new List<string>()
		  }
		});
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<TrackItContext>(options => options.UseSqlServer(connectionString));
builder.Services.AddAutoMapper(typeof(IUserService));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
	var dataContext = scope.ServiceProvider.GetRequiredService<TrackItContext>();
	dataContext.Database.EnsureCreated();
	dataContext.Database.Migrate();
}

app.Run();
