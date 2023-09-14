using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrackIt.Services.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ActivityLevel",
                columns: table => new
                {
                    ActivityLevelID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: false),
                    Multiplier = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ActivityLevel", x => x.ActivityLevelID);
                });

            migrationBuilder.CreateTable(
                name: "Goals",
                columns: table => new
                {
                    GoalID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nchar(20)", fixedLength: true, maxLength: 20, nullable: true),
                    Description = table.Column<string>(type: "nchar(100)", fixedLength: true, maxLength: 100, nullable: true),
                    TargetProtein = table.Column<double>(type: "float", nullable: true),
                    TargetCalories = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Goals", x => x.GoalID);
                });

            migrationBuilder.CreateTable(
                name: "Ingredients",
                columns: table => new
                {
                    IngredientID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nchar(30)", fixedLength: true, maxLength: 30, nullable: true),
                    Protein = table.Column<double>(type: "float", nullable: true),
                    Fat = table.Column<double>(type: "float", nullable: true),
                    Carbs = table.Column<double>(type: "float", nullable: true),
                    Calories = table.Column<double>(type: "float", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ingredients", x => x.IngredientID);
                });

            migrationBuilder.CreateTable(
                name: "Meals",
                columns: table => new
                {
                    MealID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Fat = table.Column<double>(type: "float", nullable: true),
                    Calories = table.Column<double>(type: "float", nullable: true),
                    Carbs = table.Column<double>(type: "float", nullable: true),
                    Protein = table.Column<double>(type: "float", nullable: true),
                    Name = table.Column<string>(type: "nchar(50)", fixedLength: true, maxLength: 50, nullable: true),
                    Description = table.Column<string>(type: "nchar(200)", fixedLength: true, maxLength: 200, nullable: true),
                    Image = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Meal", x => x.MealID);
                });

            migrationBuilder.CreateTable(
                name: "Preferences",
                columns: table => new
                {
                    PreferenceID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Preferences", x => x.PreferenceID);
                });

            migrationBuilder.CreateTable(
                name: "Tags",
                columns: table => new
                {
                    TagID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true),
                    Description = table.Column<string>(type: "nchar(60)", fixedLength: true, maxLength: 60, nullable: true),
                    Color = table.Column<string>(type: "nchar(10)", fixedLength: true, maxLength: 10, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Table_1", x => x.TagID);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true),
                    LastName = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true),
                    Email = table.Column<string>(type: "nchar(30)", fixedLength: true, maxLength: 30, nullable: true),
                    Username = table.Column<string>(type: "nchar(15)", fixedLength: true, maxLength: 15, nullable: true),
                    Password = table.Column<string>(type: "nchar(30)", fixedLength: true, maxLength: 30, nullable: true),
                    Salt = table.Column<string>(type: "nchar(16)", fixedLength: true, maxLength: 16, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.UserID);
                });

            migrationBuilder.CreateTable(
                name: "MealsIngredients",
                columns: table => new
                {
                    MealIngredientsID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MealID = table.Column<int>(type: "int", nullable: false),
                    IngredientID = table.Column<int>(type: "int", nullable: false),
                    IngredientQuantity = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MealIngredients", x => x.MealIngredientsID);
                    table.ForeignKey(
                        name: "FK_MealsIngredients_Ingredients",
                        column: x => x.IngredientID,
                        principalTable: "Ingredients",
                        principalColumn: "IngredientID");
                    table.ForeignKey(
                        name: "FK_MealsIngredients_Meal",
                        column: x => x.MealID,
                        principalTable: "Meals",
                        principalColumn: "MealID");
                });

            migrationBuilder.CreateTable(
                name: "TagsMeals",
                columns: table => new
                {
                    TagMealID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TagID = table.Column<int>(type: "int", nullable: false),
                    MealID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TagMeals", x => x.TagMealID);
                    table.ForeignKey(
                        name: "FK_TagsMeals_Meal",
                        column: x => x.MealID,
                        principalTable: "Meals",
                        principalColumn: "MealID");
                    table.ForeignKey(
                        name: "FK_TagsMeals_Tags",
                        column: x => x.TagID,
                        principalTable: "Tags",
                        principalColumn: "TagID");
                });

            migrationBuilder.CreateTable(
                name: "Admins",
                columns: table => new
                {
                    AdminID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Admins", x => x.AdminID);
                    table.ForeignKey(
                        name: "FK_Admins_Users",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "GeneralUsers",
                columns: table => new
                {
                    GeneralUserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Gender = table.Column<string>(type: "nchar(10)", fixedLength: true, maxLength: 10, nullable: true),
                    DateOfBirth = table.Column<DateTime>(type: "date", nullable: true),
                    Height = table.Column<double>(type: "float", nullable: true),
                    Weight = table.Column<double>(type: "float", nullable: true),
                    TargetWeight = table.Column<double>(type: "float", nullable: true),
                    ActivityLevelID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GeneralUser", x => x.GeneralUserID);
                    table.ForeignKey(
                        name: "FK_GeneralUsers_ActivityLevel",
                        column: x => x.ActivityLevelID,
                        principalTable: "ActivityLevel",
                        principalColumn: "ActivityLevelID");
                    table.ForeignKey(
                        name: "FK_GeneralUsers_Users",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "DailyIntake",
                columns: table => new
                {
                    DailyIntakeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Day = table.Column<DateTime>(type: "date", nullable: true),
                    Calories = table.Column<double>(type: "float", nullable: true),
                    Carbs = table.Column<double>(type: "float", nullable: true),
                    Protein = table.Column<double>(type: "float", nullable: true),
                    Fat = table.Column<double>(type: "float", nullable: true),
                    Fiber = table.Column<double>(type: "float", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DailyIntake", x => x.DailyIntakeID);
                    table.ForeignKey(
                        name: "FK_DailyIntake_Users",
                        column: x => x.UserID,
                        principalTable: "GeneralUsers",
                        principalColumn: "GeneralUserID");
                });

            migrationBuilder.CreateTable(
                name: "UsersGoals",
                columns: table => new
                {
                    UsersGoalsID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    GoalID = table.Column<int>(type: "int", nullable: true),
                    StartDate = table.Column<DateTime>(type: "date", nullable: true),
                    EndDate = table.Column<DateTime>(type: "date", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UsersGoals", x => x.UsersGoalsID);
                    table.ForeignKey(
                        name: "FK_UsersGoals_GeneralUsers",
                        column: x => x.UserID,
                        principalTable: "GeneralUsers",
                        principalColumn: "GeneralUserID");
                    table.ForeignKey(
                        name: "FK_UsersGoals_Goals",
                        column: x => x.GoalID,
                        principalTable: "Goals",
                        principalColumn: "GoalID");
                });

            migrationBuilder.CreateTable(
                name: "UsersMeals",
                columns: table => new
                {
                    UsersMealsID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    MealID = table.Column<int>(type: "int", nullable: false),
                    DateConsumed = table.Column<DateTime>(type: "date", nullable: true),
                    Servings = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UsersMeals", x => x.UsersMealsID);
                    table.ForeignKey(
                        name: "FK_UsersMeals_Meal",
                        column: x => x.MealID,
                        principalTable: "Meals",
                        principalColumn: "MealID");
                    table.ForeignKey(
                        name: "FK_UsersMeals_Users",
                        column: x => x.UserID,
                        principalTable: "GeneralUsers",
                        principalColumn: "GeneralUserID");
                });

            migrationBuilder.CreateTable(
                name: "UsersPreferences",
                columns: table => new
                {
                    UserPreferenceID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    PreferenceID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UsersPreferences", x => x.UserPreferenceID);
                    table.ForeignKey(
                        name: "FK_UsersPreferences_GeneralUsers",
                        column: x => x.UserID,
                        principalTable: "GeneralUsers",
                        principalColumn: "GeneralUserID");
                    table.ForeignKey(
                        name: "FK_UsersPreferences_Preferences",
                        column: x => x.PreferenceID,
                        principalTable: "Preferences",
                        principalColumn: "PreferenceID");
                });

            migrationBuilder.CreateTable(
                name: "WeightOverTime",
                columns: table => new
                {
                    LogID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Weight = table.Column<double>(type: "float", nullable: true),
                    DateLogged = table.Column<DateTime>(type: "date", nullable: true),
                    Comment = table.Column<string>(type: "nchar(30)", fixedLength: true, maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WeightOverTime", x => x.LogID);
                    table.ForeignKey(
                        name: "FK_WeightOverTime_Users",
                        column: x => x.UserID,
                        principalTable: "GeneralUsers",
                        principalColumn: "GeneralUserID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Admins_UserID",
                table: "Admins",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_DailyIntake_UserID",
                table: "DailyIntake",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_GeneralUsers_ActivityLevelID",
                table: "GeneralUsers",
                column: "ActivityLevelID");

            migrationBuilder.CreateIndex(
                name: "IX_GeneralUsers_UserID",
                table: "GeneralUsers",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_MealsIngredients_IngredientID",
                table: "MealsIngredients",
                column: "IngredientID");

            migrationBuilder.CreateIndex(
                name: "IX_MealsIngredients_MealID",
                table: "MealsIngredients",
                column: "MealID");

            migrationBuilder.CreateIndex(
                name: "IX_TagsMeals_MealID",
                table: "TagsMeals",
                column: "MealID");

            migrationBuilder.CreateIndex(
                name: "IX_TagsMeals_TagID",
                table: "TagsMeals",
                column: "TagID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersGoals_GoalID",
                table: "UsersGoals",
                column: "GoalID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersGoals_UserID",
                table: "UsersGoals",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersMeals_MealID",
                table: "UsersMeals",
                column: "MealID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersMeals_UserID",
                table: "UsersMeals",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersPreferences_PreferenceID",
                table: "UsersPreferences",
                column: "PreferenceID");

            migrationBuilder.CreateIndex(
                name: "IX_UsersPreferences_UserID",
                table: "UsersPreferences",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_WeightOverTime_UserID",
                table: "WeightOverTime",
                column: "UserID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Admins");

            migrationBuilder.DropTable(
                name: "DailyIntake");

            migrationBuilder.DropTable(
                name: "MealsIngredients");

            migrationBuilder.DropTable(
                name: "TagsMeals");

            migrationBuilder.DropTable(
                name: "UsersGoals");

            migrationBuilder.DropTable(
                name: "UsersMeals");

            migrationBuilder.DropTable(
                name: "UsersPreferences");

            migrationBuilder.DropTable(
                name: "WeightOverTime");

            migrationBuilder.DropTable(
                name: "Ingredients");

            migrationBuilder.DropTable(
                name: "Tags");

            migrationBuilder.DropTable(
                name: "Goals");

            migrationBuilder.DropTable(
                name: "Meals");

            migrationBuilder.DropTable(
                name: "Preferences");

            migrationBuilder.DropTable(
                name: "GeneralUsers");

            migrationBuilder.DropTable(
                name: "ActivityLevel");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
