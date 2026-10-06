using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class AddFavoriteCinema : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "FavoriteCinemas",
                columns: table => new
                {
                    FavoriteCinemaId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CinemaId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FavoriteCinemas", x => x.FavoriteCinemaId);
                    table.ForeignKey(
                        name: "FK_FavoriteCinemas_Cinemas_CinemaId",
                        column: x => x.CinemaId,
                        principalTable: "Cinemas",
                        principalColumn: "CinemaId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_FavoriteCinemas_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8698), new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8715) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8718), new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8718) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8720), new DateTime(2026, 3, 28, 5, 45, 55, 197, DateTimeKind.Local).AddTicks(8721) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST023",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5669), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5670) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST024",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5672), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5673) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST025",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5675), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5675) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST026",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5678), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5679) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST027",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5681), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5682) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST028",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5684), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5688) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST029",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5690), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5691) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST030",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5694), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5694) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST031",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5702), new DateTime(2026, 3, 27, 22, 45, 55, 191, DateTimeKind.Utc).AddTicks(5703) });

            migrationBuilder.CreateIndex(
                name: "IX_FavoriteCinemas_CinemaId",
                table: "FavoriteCinemas",
                column: "CinemaId");

            migrationBuilder.CreateIndex(
                name: "IX_FavoriteCinemas_UserId",
                table: "FavoriteCinemas",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FavoriteCinemas");

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2387), new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2405) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2409), new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2410) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2412), new DateTime(2026, 3, 28, 5, 24, 44, 842, DateTimeKind.Local).AddTicks(2412) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST023",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4308), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4309) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST024",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4311), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4312) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST025",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4314), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4315) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST026",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4317), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4318) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST027",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4320), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4321) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST028",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4323), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4324) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST029",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4326), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4327) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST030",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4329), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4330) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST031",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4332), new DateTime(2026, 3, 27, 22, 24, 44, 841, DateTimeKind.Utc).AddTicks(4333) });
        }
    }
}
