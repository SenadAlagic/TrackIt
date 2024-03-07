using Microsoft.EntityFrameworkCore;

namespace TrackIt.Services.Database;

public partial class TrackItContext : DbContext
{
	public TrackItContext()
	{
	}

	public TrackItContext(DbContextOptions<TrackItContext> options)
		: base(options)
	{
	}

	public virtual DbSet<ActivityLevel> ActivityLevels { get; set; }

	public virtual DbSet<Admin> Admins { get; set; }

	public virtual DbSet<DailyIntake> DailyIntakes { get; set; }

	public virtual DbSet<GeneralUser> GeneralUsers { get; set; }

	public virtual DbSet<Goal> Goals { get; set; }

	public virtual DbSet<Ingredient> Ingredients { get; set; }

	public virtual DbSet<Meal> Meals { get; set; }

	public virtual DbSet<MealsIngredient> MealsIngredients { get; set; }

	public virtual DbSet<Preference> Preferences { get; set; }

	public virtual DbSet<Tag> Tags { get; set; }

	public virtual DbSet<TagsMeal> TagsMeals { get; set; }

	public virtual DbSet<User> Users { get; set; }

	public virtual DbSet<UsersMeal> UsersMeals { get; set; }

	public virtual DbSet<UsersPreference> UsersPreferences { get; set; }

	public virtual DbSet<WeightOverTime> WeightOverTimes { get; set; }

	//protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
	//    => optionsBuilder.UseSqlServer("Name=ConnectionStrings:DefaultConnection");

	protected override void OnModelCreating(ModelBuilder modelBuilder)
	{
		modelBuilder.Entity<ActivityLevel>(entity =>
		{
			entity.ToTable("ActivityLevel");

			entity.Property(e => e.ActivityLevelId).HasColumnName("ActivityLevelID");
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<Admin>(entity =>
		{
			entity.Property(e => e.AdminId).HasColumnName("AdminID");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.User).WithMany(p => p.Admins)
				.HasForeignKey(d => d.UserId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_Admins_Users");
		});

		modelBuilder.Entity<DailyIntake>(entity =>
		{
			entity.ToTable("DailyIntake");

			entity.Property(e => e.DailyIntakeId).HasColumnName("DailyIntakeID");
			entity.Property(e => e.Day).HasColumnType("date");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.User).WithMany(p => p.DailyIntakes)
				.HasForeignKey(d => d.UserId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_DailyIntake_Users");
		});

		modelBuilder.Entity<GeneralUser>(entity =>
		{
			entity.HasKey(e => e.GeneralUserId).HasName("PK_GeneralUser");

			entity.Property(e => e.GeneralUserId).HasColumnName("GeneralUserID");
			entity.Property(e => e.ActivityLevelId).HasColumnName("ActivityLevelID");
			entity.Property(e => e.DateOfBirth).HasColumnType("date");
			entity.Property(e => e.Gender).HasMaxLength(50);
			entity.Property(e => e.GoalId).HasColumnName("GoalID");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.ActivityLevel).WithMany(p => p.GeneralUsers)
				.HasForeignKey(d => d.ActivityLevelId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_GeneralUsers_ActivityLevel");

			entity.HasOne(d => d.Goal).WithMany(p => p.GeneralUsers)
				.HasForeignKey(d => d.GoalId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_GeneralUsers_Goals");

			entity.HasOne(d => d.User).WithMany(p => p.GeneralUsers)
				.HasForeignKey(d => d.UserId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_GeneralUsers_Users");
		});

		modelBuilder.Entity<Goal>(entity =>
		{
			entity.Property(e => e.GoalId).HasColumnName("GoalID");
			entity.Property(e => e.Description).HasMaxLength(100);
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<Ingredient>(entity =>
		{
			entity.Property(e => e.IngredientId).HasColumnName("IngredientID");
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<Meal>(entity =>
		{
			entity.HasKey(e => e.MealId).HasName("PK_Meal");

			entity.Property(e => e.MealId).HasColumnName("MealID");
			entity.Property(e => e.Description).HasMaxLength(200);
			entity.Property(e => e.Image).HasMaxLength(50);
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<MealsIngredient>(entity =>
		{
			entity.HasKey(e => e.MealIngredientsId).HasName("PK_MealIngredients");

			entity.Property(e => e.MealIngredientsId).HasColumnName("MealIngredientsID");
			entity.Property(e => e.IngredientId).HasColumnName("IngredientID");
			entity.Property(e => e.MealId).HasColumnName("MealID");

			entity.HasOne(d => d.Ingredient).WithMany(p => p.MealsIngredients)
				.HasForeignKey(d => d.IngredientId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_MealsIngredients_Ingredients");

			entity.HasOne(d => d.Meal).WithMany(p => p.MealsIngredients)
				.HasForeignKey(d => d.MealId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_MealsIngredients_Meal");
		});

		modelBuilder.Entity<Preference>(entity =>
		{
			entity.Property(e => e.PreferenceId).HasColumnName("PreferenceID");
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<Tag>(entity =>
		{
			entity.HasKey(e => e.TagId).HasName("PK_Table_1");

			entity.Property(e => e.TagId).HasColumnName("TagID");
			entity.Property(e => e.Color).HasMaxLength(50);
			entity.Property(e => e.Description).HasMaxLength(60);
			entity.Property(e => e.Name).HasMaxLength(50);
		});

		modelBuilder.Entity<TagsMeal>(entity =>
		{
			entity.HasKey(e => e.TagMealId).HasName("PK_TagMeals");

			entity.Property(e => e.TagMealId).HasColumnName("TagMealID");
			entity.Property(e => e.MealId).HasColumnName("MealID");
			entity.Property(e => e.TagId).HasColumnName("TagID");

			entity.HasOne(d => d.Meal).WithMany(p => p.TagsMeals)
				.HasForeignKey(d => d.MealId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_TagsMeals_Meal");

			entity.HasOne(d => d.Tag).WithMany(p => p.TagsMeals)
				.HasForeignKey(d => d.TagId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_TagsMeals_Tags");
		});

		modelBuilder.Entity<User>(entity =>
		{
			entity.Property(e => e.UserId).HasColumnName("UserID");
			entity.Property(e => e.Email).HasMaxLength(50);
			entity.Property(e => e.FirstName).HasMaxLength(50);
			entity.Property(e => e.LastName).HasMaxLength(50);
			entity.Property(e => e.Password).HasMaxLength(50);
			entity.Property(e => e.Salt).HasMaxLength(50);
			entity.Property(e => e.Username).HasMaxLength(50);
		});

		modelBuilder.Entity<UsersMeal>(entity =>
		{
			entity.HasKey(e => e.UsersMealsId);

			entity.Property(e => e.UsersMealsId).HasColumnName("UsersMealsID");
			entity.Property(e => e.DateConsumed).HasColumnType("date");
			entity.Property(e => e.MealId).HasColumnName("MealID");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.Meal).WithMany(p => p.UsersMeals)
				.HasForeignKey(d => d.MealId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_UsersMeals_Meal");

			entity.HasOne(d => d.User).WithMany(p => p.UsersMeals)
				.HasForeignKey(d => d.UserId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_UsersMeals_Users");
		});

		modelBuilder.Entity<UsersPreference>(entity =>
		{
			entity.HasKey(e => e.UserPreferenceId);

			entity.Property(e => e.UserPreferenceId).HasColumnName("UserPreferenceID");
			entity.Property(e => e.PreferenceId).HasColumnName("PreferenceID");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.Preference).WithMany(p => p.UsersPreferences)
				.HasForeignKey(d => d.PreferenceId)
				.HasConstraintName("FK_UsersPreferences_Preferences");

			entity.HasOne(d => d.User).WithMany(p => p.UsersPreferences)
				.HasForeignKey(d => d.UserId)
				.HasConstraintName("FK_UsersPreferences_GeneralUsers");
		});

		modelBuilder.Entity<WeightOverTime>(entity =>
		{
			entity.HasKey(e => e.LogId);

			entity.ToTable("WeightOverTime");

			entity.Property(e => e.LogId).HasColumnName("LogID");
			entity.Property(e => e.Comment).HasMaxLength(50);
			entity.Property(e => e.DateLogged).HasColumnType("date");
			entity.Property(e => e.UserId).HasColumnName("UserID");

			entity.HasOne(d => d.User).WithMany(p => p.WeightOverTimes)
				.HasForeignKey(d => d.UserId)
				.OnDelete(DeleteBehavior.ClientSetNull)
				.HasConstraintName("FK_WeightOverTime_Users");
		});

		OnModelCreatingPartial(modelBuilder);
	}

	partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
