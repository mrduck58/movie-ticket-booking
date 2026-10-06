using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class addMoreData1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3355), new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3358) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3360), new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3361) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3364), new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(3364) });

            migrationBuilder.InsertData(
                table: "Showtimes",
                columns: new[] { "ShowtimeId", "CreatedAt", "EndTime", "MovieId", "RoomId", "StartTime", "Status", "UpdatedAt" },
                values: new object[,]
                {
                    { "ST201", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1315), new DateTime(2026, 6, 25, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 25, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1326) },
                    { "ST202", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1328), new DateTime(2026, 6, 25, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R006", new DateTime(2026, 6, 25, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1329) },
                    { "ST203", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1331), new DateTime(2026, 6, 25, 18, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R011", new DateTime(2026, 6, 25, 16, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1331) },
                    { "ST204", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1333), new DateTime(2026, 6, 25, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV002", "R001", new DateTime(2026, 6, 25, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1334) },
                    { "ST205", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1336), new DateTime(2026, 6, 25, 14, 30, 0, 0, DateTimeKind.Unspecified), "MOV003", "R006", new DateTime(2026, 6, 25, 12, 30, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1336) },
                    { "ST206", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1343), new DateTime(2026, 6, 25, 17, 0, 0, 0, DateTimeKind.Unspecified), "MOV004", "R011", new DateTime(2026, 6, 25, 15, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1344) },
                    { "ST207", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1346), new DateTime(2026, 6, 25, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV005", "R002", new DateTime(2026, 6, 25, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1346) },
                    { "ST208", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1348), new DateTime(2026, 6, 25, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV006", "R007", new DateTime(2026, 6, 25, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1349) },
                    { "ST209", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1351), new DateTime(2026, 6, 25, 18, 0, 0, 0, DateTimeKind.Unspecified), "MOV007", "R012", new DateTime(2026, 6, 25, 16, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1351) },
                    { "ST210", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1353), new DateTime(2026, 6, 25, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV008", "R003", new DateTime(2026, 6, 25, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1354) },
                    { "ST211", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1356), new DateTime(2026, 6, 25, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV009", "R008", new DateTime(2026, 6, 25, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1357) },
                    { "ST212", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1359), new DateTime(2026, 6, 25, 18, 0, 0, 0, DateTimeKind.Unspecified), "MOV010", "R013", new DateTime(2026, 6, 25, 16, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 3, 26, 14, 10, 24, 99, DateTimeKind.Local).AddTicks(1359) }
                });

            migrationBuilder.InsertData(
                table: "ShowtimeTicketTypes",
                columns: new[] { "ShowtimeTicketTypeId", "Price", "ShowtimeId", "TicketTypeId" },
                values: new object[,]
                {
                    { "STT201", 120000.0, "ST201", "TT001" },
                    { "STT202", 120000.0, "ST202", "TT001" },
                    { "STT203", 120000.0, "ST203", "TT001" },
                    { "STT204", 120000.0, "ST204", "TT001" },
                    { "STT205", 120000.0, "ST205", "TT001" },
                    { "STT206", 120000.0, "ST206", "TT001" },
                    { "STT207", 120000.0, "ST207", "TT001" },
                    { "STT208", 120000.0, "ST208", "TT001" },
                    { "STT209", 120000.0, "ST209", "TT001" },
                    { "STT210", 120000.0, "ST210", "TT001" },
                    { "STT211", 120000.0, "ST211", "TT001" },
                    { "STT212", 120000.0, "ST212", "TT001" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT201");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT202");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT203");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT204");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT205");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT206");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT207");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT208");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT209");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT210");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT211");

            migrationBuilder.DeleteData(
                table: "ShowtimeTicketTypes",
                keyColumn: "ShowtimeTicketTypeId",
                keyValue: "STT212");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST201");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST202");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST203");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST204");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST205");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST206");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST207");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST208");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST209");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST210");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST211");

            migrationBuilder.DeleteData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST212");

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
        }
    }
}
