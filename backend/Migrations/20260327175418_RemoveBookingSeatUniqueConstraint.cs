using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class RemoveBookingSeatUniqueConstraint : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_BookingSeats_SeatId_ShowtimeTicketTypeId",
                table: "BookingSeats");

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6263), new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6280) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6283), new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6283) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6285), new DateTime(2026, 3, 28, 0, 54, 15, 803, DateTimeKind.Local).AddTicks(6286) });

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeats_SeatId_ShowtimeTicketTypeId",
                table: "BookingSeats",
                columns: new[] { "SeatId", "ShowtimeTicketTypeId" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_BookingSeats_SeatId_ShowtimeTicketTypeId",
                table: "BookingSeats");

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4776), new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4785) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4787), new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4788) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4790), new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4791) });

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeats_SeatId_ShowtimeTicketTypeId",
                table: "BookingSeats",
                columns: new[] { "SeatId", "ShowtimeTicketTypeId" },
                unique: true);
        }
    }
}
