using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace TrackIt.Services.Migrations
{
    /// <inheritdoc />
    public partial class usersmealsseed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "GeneralUsers",
                keyColumn: "GeneralUserID",
                keyValue: 1,
                column: "DateOfBirth",
                value: new DateTime(2024, 6, 25, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(6041));

            migrationBuilder.InsertData(
                table: "Ingredients",
                columns: new[] { "IngredientID", "Calories", "Carbs", "Fat", "Image", "Name", "Protein" },
                values: new object[,]
                {
                    { 11, 176.0, 0.0, 4.2999999999999998, null, "Beef (Lean)", 36.0 },
                    { 12, 176.0, 0.0, 4.2999999999999998, null, "Pork (Lean)", 37.0 },
                    { 13, 576.0, 16.100000000000001, 49.200000000000003, null, "Peanut butter", 25.899999999999999 },
                    { 14, 96.0, 14.0, 0.20000000000000001, null, "Bananas", 1.0 },
                    { 15, 57.0, 14.5, 0.29999999999999999, null, "Blueberries", 0.69999999999999996 },
                    { 16, 579.0, 21.600000000000001, 49.200000000000003, null, "Almonds", 21.199999999999999 }
                });

            migrationBuilder.UpdateData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 4,
                column: "Calories",
                value: 104.0);

            migrationBuilder.InsertData(
                table: "Meals",
                columns: new[] { "MealID", "Calories", "Carbs", "Description", "Fat", "Image", "Name", "Protein" },
                values: new object[,]
                {
                    { 6, 302.0, 10.85, "A delightful toast spread with creamy peanut butter and topped with slices of ripe banana, offering a delectable combination of flavors and textures.", 24.600000000000001, null, "Peanut Butter Banana", 13.15 },
                    { 7, 636.0, 36.100000000000001, "A refreshing smoothie blending juicy blueberries, protein-rich Greek yogurt, and crunchy almonds, sweetened with a touch of honey for a nutritious and energizing treat.", 49.5, null, "Blueberry Almond Smoothie", 21.899999999999999 },
                    { 8, 315.0, 9.9000000000000004, "A savory stir-fry featuring lean beef and broccoli florets, sautéed with garlic and ginger, and served over a bed of brown rice and lentils for a wholesome and satisfying meal.", 7.0499999999999998, null, "Beef and Broccoli Stir-fry", 58.200000000000003 },
                    { 9, 425.0, 56.0, "Tender baked chicken with a side of fluffy white rice, seasoned with garlic and served with a medley of sautéed bell peppers, onions, and zucchini.", 4.2000000000000002, null, "Baked Chicken and Rice", 36.399999999999999 }
                });

            migrationBuilder.InsertData(
                table: "UsersMeals",
                columns: new[] { "UsersMealsID", "DateConsumed", "MealID", "Servings", "UserID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5907), 1, 1, 1 },
                    { 2, new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5948), 2, 1, 1 },
                    { 3, new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5951), 3, 1, 1 },
                    { 4, new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5953), 1, 1, 1 },
                    { 5, new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5955), 2, 1, 1 },
                    { 6, new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5958), 3, 1, 1 },
                    { 7, new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5960), 2, 1, 1 },
                    { 8, new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5963), 3, 1, 1 },
                    { 9, new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5965), 4, 1, 1 },
                    { 10, new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5967), 4, 1, 1 },
                    { 11, new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5970), 5, 1, 1 },
                    { 17, new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5984), 1, 1, 1 },
                    { 19, new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5988), 4, 1, 1 }
                });

            migrationBuilder.InsertData(
                table: "MealsIngredients",
                columns: new[] { "MealIngredientsID", "IngredientID", "IngredientQuantity", "MealID" },
                values: new object[,]
                {
                    { 14, 13, 100, 6 },
                    { 15, 14, 100, 6 },
                    { 16, 15, 100, 7 },
                    { 17, 16, 100, 7 },
                    { 18, 11, 100, 8 },
                    { 19, 4, 100, 8 },
                    { 20, 3, 100, 9 },
                    { 21, 1, 100, 9 }
                });

            migrationBuilder.InsertData(
                table: "TagsMeals",
                columns: new[] { "TagMealID", "MealID", "TagID" },
                values: new object[,]
                {
                    { 30, 6, 3 },
                    { 31, 6, 4 },
                    { 32, 7, 6 },
                    { 33, 7, 7 },
                    { 34, 8, 10 },
                    { 35, 8, 3 },
                    { 36, 9, 4 },
                    { 37, 9, 6 },
                    { 38, 9, 7 },
                    { 39, 9, 10 }
                });

            migrationBuilder.InsertData(
                table: "UsersMeals",
                columns: new[] { "UsersMealsID", "DateConsumed", "MealID", "Servings", "UserID" },
                values: new object[,]
                {
                    { 12, new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5972), 6, 1, 1 },
                    { 13, new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5974), 6, 1, 1 },
                    { 14, new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5977), 7, 1, 1 },
                    { 15, new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5979), 8, 1, 1 },
                    { 16, new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5981), 9, 1, 1 },
                    { 18, new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5986), 9, 1, 1 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "MealsIngredients",
                keyColumn: "MealIngredientsID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "TagsMeals",
                keyColumn: "TagMealID",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Ingredients",
                keyColumn: "IngredientID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 9);

            migrationBuilder.UpdateData(
                table: "GeneralUsers",
                keyColumn: "GeneralUserID",
                keyValue: 1,
                column: "DateOfBirth",
                value: new DateTime(2024, 6, 23, 17, 52, 6, 653, DateTimeKind.Local).AddTicks(8964));

            migrationBuilder.UpdateData(
                table: "Meals",
                keyColumn: "MealID",
                keyValue: 4,
                column: "Calories",
                value: 1044.0);
        }
    }
}
