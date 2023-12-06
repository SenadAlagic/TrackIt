using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using TrackIt;
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
builder.Services.AddTransient<IGeneralUserService, GeneralUserService>();
builder.Services.AddTransient<IAdminService, AdminService>();
builder.Services.AddTransient<IDailyIntakeService, DailyIntakeService>();

builder.Services.AddControllers(x =>
{
	x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
	c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme()
	{
		Type = SecuritySchemeType.Http,
		Scheme = "basic"
	});
	c.AddSecurityRequirement(new OpenApiSecurityRequirement()
	{
		{
			new OpenApiSecurityScheme
			{
				Reference=new OpenApiReference{Type=ReferenceType.SecurityScheme, Id="basicAuth" }
			},
			new string[]{}
		}
	});
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<TrackItContext>(options => options.UseSqlServer(connectionString));
builder.Services.AddAutoMapper(typeof(IUserService));
builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

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
	//dataContext.Database.EnsureCreated();
	//dataContext.Database.Migrate();
}

app.Run();
