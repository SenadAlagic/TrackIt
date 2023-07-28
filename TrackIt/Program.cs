using Microsoft.EntityFrameworkCore;
using TrackIt.Services.Database;
using TrackIt.Services.Interfaces;
using TrackIt.Services.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IMealsService, MealsService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IGeneralUserService, GeneralUserService>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

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

app.UseAuthorization();

app.MapControllers();

app.Run();
