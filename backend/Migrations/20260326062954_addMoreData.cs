using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class addMoreData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC001",
                column: "ImageUrl",
                value: "https://image.tmdb.org/t/p/w500/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC002",
                column: "ImageUrl",
                value: "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC003",
                column: "ImageUrl",
                value: "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC004",
                column: "ImageUrl",
                value: "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg");

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3597), new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3604) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3606), new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3607) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3608), new DateTime(2026, 3, 26, 13, 29, 53, 507, DateTimeKind.Local).AddTicks(3609) });

            migrationBuilder.InsertData(
                table: "Showtimes",
                columns: new[] { "ShowtimeId", "CreatedAt", "EndTime", "MovieId", "RoomId", "StartTime", "Status", "UpdatedAt" },
                values: new object[,]
                {
                    { "ST101", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV002", "R001", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST102", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV002", "R002", new DateTime(2026, 6, 23, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST103", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV003", "R003", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST104", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV004", "R001", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST105", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV005", "R002", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST106", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV006", "R003", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST107", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV007", "R001", new DateTime(2026, 6, 23, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST108", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV008", "R002", new DateTime(2026, 6, 23, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST109", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV009", "R003", new DateTime(2026, 6, 23, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST110", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 18, 0, 0, 0, DateTimeKind.Unspecified), "MOV010", "R001", new DateTime(2026, 6, 23, 16, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "ShowtimeTicketTypes",
                columns: new[] { "ShowtimeTicketTypeId", "Price", "ShowtimeId", "TicketTypeId" },
                values: new object[,]
                {
                    { "STT101", 120000.0, "ST101", "TT001" },
                    { "STT102", 170000.0, "ST102", "TT002" },
                    { "STT103", 220000.0, "ST103", "TT003" },
                    { "STT104", 120000.0, "ST104", "TT001" },
                    { "STT105", 170000.0, "ST105", "TT002" },
                    { "STT106", 220000.0, "ST106", "TT003" },
                    { "STT107", 120000.0, "ST107", "TT001" },
                    { "STT108", 170000.0, "ST108", "TT002" },
                    { "STT109", 220000.0, "ST109", "TT003" },
                    { "STT110", 120000.0, "ST110", "TT001" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT101");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT102");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT103");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT104");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT105");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT106");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT107");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT108");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT109");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT110");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST101");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST102");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST103");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST104");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST105");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST106");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST107");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST108");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST109");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST110");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC001",
                column: "ImageUrl",
                value: "https://www.bhdstar.vn/wp-content/uploads/2025/06/SINGLE-COMBO-1-1.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC002",
                column: "ImageUrl",
                value: "https://www.bhdstar.vn/wp-content/uploads/2025/06/COUPLE-COMBO-1-1.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC003",
                column: "ImageUrl",
                value: "https://www.bhdstar.vn/wp-content/uploads/2025/05/TRA-3-VI-2-1.jpg");

            migrationBuilder.UpdateData(
                table: "FoodCombos",
                keyColumn: "FoodComboId",
                keyValue: "FC004",
                column: "ImageUrl",
                value: "https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56");

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5084), new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5095) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5096), new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5096) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5097), new DateTime(2026, 3, 26, 4, 33, 17, 956, DateTimeKind.Local).AddTicks(5102) });
        }
    }
}
