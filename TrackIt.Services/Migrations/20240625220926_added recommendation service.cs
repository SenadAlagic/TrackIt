using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TrackIt.Services.Migrations
{
    /// <inheritdoc />
    public partial class addedrecommendationservice : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "RecommendedResults",
                columns: table => new
                {
                    RecommendedResultId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MealId = table.Column<int>(type: "int", nullable: false),
                    RecommendedMealId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RecommendedResults", x => x.RecommendedResultId);
                });

            migrationBuilder.UpdateData(
                table: "GeneralUsers",
                keyColumn: "GeneralUserID",
                keyValue: 1,
                column: "DateOfBirth",
                value: new DateTime(2024, 6, 26, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6543));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 1,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 25, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6394));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 2,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 25, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6434));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 3,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 25, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6437));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 4,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6439));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 5,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6442));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 6,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6444));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 7,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6447));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 8,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6449));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 9,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6451));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 10,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6454));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 11,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6456));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 12,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6459));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 13,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6461));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 14,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6463));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 15,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6466));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 16,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6468));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 17,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6471));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 18,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6473));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 19,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 0, 9, 23, 978, DateTimeKind.Local).AddTicks(6475));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RecommendedResults");

            migrationBuilder.UpdateData(
                table: "GeneralUsers",
                keyColumn: "GeneralUserID",
                keyValue: 1,
                column: "DateOfBirth",
                value: new DateTime(2024, 6, 25, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(6041));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 1,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5907));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 2,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5948));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 3,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 24, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5951));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 4,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5953));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 5,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5955));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 6,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 23, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5958));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 7,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5960));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 8,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5963));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 9,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 22, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5965));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 10,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5967));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 11,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5970));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 12,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 21, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5972));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 13,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5974));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 14,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5977));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 15,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5979));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 16,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 20, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5981));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 17,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5984));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 18,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5986));

            migrationBuilder.UpdateData(
                table: "UsersMeals",
                keyColumn: "UsersMealsID",
                keyValue: 19,
                column: "DateConsumed",
                value: new DateTime(2024, 6, 19, 17, 23, 33, 409, DateTimeKind.Local).AddTicks(5988));
        }
    }
}
