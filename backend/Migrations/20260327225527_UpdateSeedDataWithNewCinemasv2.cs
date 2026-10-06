using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSeedDataWithNewCinemasv2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Cinemas",
                columns: new[] { "CinemaId", "CreatedAt", "Hotline", "Location", "Name", "Rating", "UpdatedAt" },
                values: new object[,]
                {
                    { "C007", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "02435141791", "Ha Noi", "National Cinema Center", "4.1", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "C008", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "19002224", "Ho Chi Minh", "Galaxy Cinema Nguyen Du", "4.1", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "C009", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "19006017", "Ho Chi Minh", "CGV Gigamall Thu Duc", "4.5", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "C010", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "02837402323", "Ho Chi Minh", "Lotte Cinema Cantavil", "4.2", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM001",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6256), new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6271) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM002",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6273), new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6274) });

            migrationBuilder.UpdateData(
                table: "PaymentMethods",
                keyColumn: "PaymentMethodId",
                keyValue: "PM003",
                columns: new[] { "CreatedDate", "UpdatedDate" },
                values: new object[] { new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6276), new DateTime(2026, 3, 28, 5, 55, 23, 218, DateTimeKind.Local).AddTicks(6277) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST023",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3240), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3240) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST024",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3243), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3243) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST025",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3245), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3246) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST026",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3256), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3257) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST027",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3259), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3260) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST028",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3262), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3262) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST029",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3265), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3265) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST030",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3267), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3268) });

            migrationBuilder.UpdateData(
                table: "Showtimes",
                keyColumn: "ShowtimeId",
                keyValue: "ST031",
                columns: new[] { "CreatedAt", "UpdatedAt" },
                values: new object[] { new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3270), new DateTime(2026, 3, 27, 22, 55, 23, 216, DateTimeKind.Utc).AddTicks(3271) });

            migrationBuilder.InsertData(
                table: "Rooms",
                columns: new[] { "RoomId", "CinemaId", "Name" },
                values: new object[,]
                {
                    { "R031", "C007", "Room 1" },
                    { "R032", "C008", "Room 1" },
                    { "R033", "C009", "Room 1" },
                    { "R034", "C010", "Room 1" }
                });

            migrationBuilder.InsertData(
                table: "Seats",
                columns: new[] { "SeatId", "RoomId", "SeatName" },
                values: new object[,]
                {
                    { "SE2401", "R031", "A1" },
                    { "SE2402", "R031", "A2" },
                    { "SE2403", "R031", "A3" },
                    { "SE2404", "R031", "A4" },
                    { "SE2405", "R031", "A5" },
                    { "SE2406", "R031", "A6" },
                    { "SE2407", "R031", "A7" },
                    { "SE2408", "R031", "A8" },
                    { "SE2409", "R031", "A9" },
                    { "SE2410", "R031", "A10" },
                    { "SE2411", "R031", "B1" },
                    { "SE2412", "R031", "B2" },
                    { "SE2413", "R031", "B3" },
                    { "SE2414", "R031", "B4" },
                    { "SE2415", "R031", "B5" },
                    { "SE2416", "R031", "B6" },
                    { "SE2417", "R031", "B7" },
                    { "SE2418", "R031", "B8" },
                    { "SE2419", "R031", "B9" },
                    { "SE2420", "R031", "B10" },
                    { "SE2421", "R031", "C1" },
                    { "SE2422", "R031", "C2" },
                    { "SE2423", "R031", "C3" },
                    { "SE2424", "R031", "C4" },
                    { "SE2425", "R031", "C5" },
                    { "SE2426", "R031", "C6" },
                    { "SE2427", "R031", "C7" },
                    { "SE2428", "R031", "C8" },
                    { "SE2429", "R031", "C9" },
                    { "SE2430", "R031", "C10" },
                    { "SE2431", "R031", "D1" },
                    { "SE2432", "R031", "D2" },
                    { "SE2433", "R031", "D3" },
                    { "SE2434", "R031", "D4" },
                    { "SE2435", "R031", "D5" },
                    { "SE2436", "R031", "D6" },
                    { "SE2437", "R031", "D7" },
                    { "SE2438", "R031", "D8" },
                    { "SE2439", "R031", "D9" },
                    { "SE2440", "R031", "D10" },
                    { "SE2441", "R031", "E1" },
                    { "SE2442", "R031", "E2" },
                    { "SE2443", "R031", "E3" },
                    { "SE2444", "R031", "E4" },
                    { "SE2445", "R031", "E5" },
                    { "SE2446", "R031", "E6" },
                    { "SE2447", "R031", "E7" },
                    { "SE2448", "R031", "E8" },
                    { "SE2449", "R031", "E9" },
                    { "SE2450", "R031", "E10" },
                    { "SE2451", "R031", "F1" },
                    { "SE2452", "R031", "F2" },
                    { "SE2453", "R031", "F3" },
                    { "SE2454", "R031", "F4" },
                    { "SE2455", "R031", "F5" },
                    { "SE2456", "R031", "F6" },
                    { "SE2457", "R031", "F7" },
                    { "SE2458", "R031", "F8" },
                    { "SE2459", "R031", "F9" },
                    { "SE2460", "R031", "F10" },
                    { "SE2461", "R031", "G1" },
                    { "SE2462", "R031", "G2" },
                    { "SE2463", "R031", "G3" },
                    { "SE2464", "R031", "G4" },
                    { "SE2465", "R031", "G5" },
                    { "SE2466", "R031", "G6" },
                    { "SE2467", "R031", "G7" },
                    { "SE2468", "R031", "G8" },
                    { "SE2469", "R031", "G9" },
                    { "SE2470", "R031", "G10" },
                    { "SE2471", "R031", "H1" },
                    { "SE2472", "R031", "H2" },
                    { "SE2473", "R031", "H3" },
                    { "SE2474", "R031", "H4" },
                    { "SE2475", "R031", "H5" },
                    { "SE2476", "R031", "H6" },
                    { "SE2477", "R031", "H7" },
                    { "SE2478", "R031", "H8" },
                    { "SE2479", "R031", "H9" },
                    { "SE2480", "R031", "H10" },
                    { "SE2481", "R032", "A1" },
                    { "SE2482", "R032", "A2" },
                    { "SE2483", "R032", "A3" },
                    { "SE2484", "R032", "A4" },
                    { "SE2485", "R032", "A5" },
                    { "SE2486", "R032", "A6" },
                    { "SE2487", "R032", "A7" },
                    { "SE2488", "R032", "A8" },
                    { "SE2489", "R032", "A9" },
                    { "SE2490", "R032", "A10" },
                    { "SE2491", "R032", "B1" },
                    { "SE2492", "R032", "B2" },
                    { "SE2493", "R032", "B3" },
                    { "SE2494", "R032", "B4" },
                    { "SE2495", "R032", "B5" },
                    { "SE2496", "R032", "B6" },
                    { "SE2497", "R032", "B7" },
                    { "SE2498", "R032", "B8" },
                    { "SE2499", "R032", "B9" },
                    { "SE2500", "R032", "B10" },
                    { "SE2501", "R032", "C1" },
                    { "SE2502", "R032", "C2" },
                    { "SE2503", "R032", "C3" },
                    { "SE2504", "R032", "C4" },
                    { "SE2505", "R032", "C5" },
                    { "SE2506", "R032", "C6" },
                    { "SE2507", "R032", "C7" },
                    { "SE2508", "R032", "C8" },
                    { "SE2509", "R032", "C9" },
                    { "SE2510", "R032", "C10" },
                    { "SE2511", "R032", "D1" },
                    { "SE2512", "R032", "D2" },
                    { "SE2513", "R032", "D3" },
                    { "SE2514", "R032", "D4" },
                    { "SE2515", "R032", "D5" },
                    { "SE2516", "R032", "D6" },
                    { "SE2517", "R032", "D7" },
                    { "SE2518", "R032", "D8" },
                    { "SE2519", "R032", "D9" },
                    { "SE2520", "R032", "D10" },
                    { "SE2521", "R032", "E1" },
                    { "SE2522", "R032", "E2" },
                    { "SE2523", "R032", "E3" },
                    { "SE2524", "R032", "E4" },
                    { "SE2525", "R032", "E5" },
                    { "SE2526", "R032", "E6" },
                    { "SE2527", "R032", "E7" },
                    { "SE2528", "R032", "E8" },
                    { "SE2529", "R032", "E9" },
                    { "SE2530", "R032", "E10" },
                    { "SE2531", "R032", "F1" },
                    { "SE2532", "R032", "F2" },
                    { "SE2533", "R032", "F3" },
                    { "SE2534", "R032", "F4" },
                    { "SE2535", "R032", "F5" },
                    { "SE2536", "R032", "F6" },
                    { "SE2537", "R032", "F7" },
                    { "SE2538", "R032", "F8" },
                    { "SE2539", "R032", "F9" },
                    { "SE2540", "R032", "F10" },
                    { "SE2541", "R032", "G1" },
                    { "SE2542", "R032", "G2" },
                    { "SE2543", "R032", "G3" },
                    { "SE2544", "R032", "G4" },
                    { "SE2545", "R032", "G5" },
                    { "SE2546", "R032", "G6" },
                    { "SE2547", "R032", "G7" },
                    { "SE2548", "R032", "G8" },
                    { "SE2549", "R032", "G9" },
                    { "SE2550", "R032", "G10" },
                    { "SE2551", "R032", "H1" },
                    { "SE2552", "R032", "H2" },
                    { "SE2553", "R032", "H3" },
                    { "SE2554", "R032", "H4" },
                    { "SE2555", "R032", "H5" },
                    { "SE2556", "R032", "H6" },
                    { "SE2557", "R032", "H7" },
                    { "SE2558", "R032", "H8" },
                    { "SE2559", "R032", "H9" },
                    { "SE2560", "R032", "H10" },
                    { "SE2561", "R033", "A1" },
                    { "SE2562", "R033", "A2" },
                    { "SE2563", "R033", "A3" },
                    { "SE2564", "R033", "A4" },
                    { "SE2565", "R033", "A5" },
                    { "SE2566", "R033", "A6" },
                    { "SE2567", "R033", "A7" },
                    { "SE2568", "R033", "A8" },
                    { "SE2569", "R033", "A9" },
                    { "SE2570", "R033", "A10" },
                    { "SE2571", "R033", "B1" },
                    { "SE2572", "R033", "B2" },
                    { "SE2573", "R033", "B3" },
                    { "SE2574", "R033", "B4" },
                    { "SE2575", "R033", "B5" },
                    { "SE2576", "R033", "B6" },
                    { "SE2577", "R033", "B7" },
                    { "SE2578", "R033", "B8" },
                    { "SE2579", "R033", "B9" },
                    { "SE2580", "R033", "B10" },
                    { "SE2581", "R033", "C1" },
                    { "SE2582", "R033", "C2" },
                    { "SE2583", "R033", "C3" },
                    { "SE2584", "R033", "C4" },
                    { "SE2585", "R033", "C5" },
                    { "SE2586", "R033", "C6" },
                    { "SE2587", "R033", "C7" },
                    { "SE2588", "R033", "C8" },
                    { "SE2589", "R033", "C9" },
                    { "SE2590", "R033", "C10" },
                    { "SE2591", "R033", "D1" },
                    { "SE2592", "R033", "D2" },
                    { "SE2593", "R033", "D3" },
                    { "SE2594", "R033", "D4" },
                    { "SE2595", "R033", "D5" },
                    { "SE2596", "R033", "D6" },
                    { "SE2597", "R033", "D7" },
                    { "SE2598", "R033", "D8" },
                    { "SE2599", "R033", "D9" },
                    { "SE2600", "R033", "D10" },
                    { "SE2601", "R033", "E1" },
                    { "SE2602", "R033", "E2" },
                    { "SE2603", "R033", "E3" },
                    { "SE2604", "R033", "E4" },
                    { "SE2605", "R033", "E5" },
                    { "SE2606", "R033", "E6" },
                    { "SE2607", "R033", "E7" },
                    { "SE2608", "R033", "E8" },
                    { "SE2609", "R033", "E9" },
                    { "SE2610", "R033", "E10" },
                    { "SE2611", "R033", "F1" },
                    { "SE2612", "R033", "F2" },
                    { "SE2613", "R033", "F3" },
                    { "SE2614", "R033", "F4" },
                    { "SE2615", "R033", "F5" },
                    { "SE2616", "R033", "F6" },
                    { "SE2617", "R033", "F7" },
                    { "SE2618", "R033", "F8" },
                    { "SE2619", "R033", "F9" },
                    { "SE2620", "R033", "F10" },
                    { "SE2621", "R033", "G1" },
                    { "SE2622", "R033", "G2" },
                    { "SE2623", "R033", "G3" },
                    { "SE2624", "R033", "G4" },
                    { "SE2625", "R033", "G5" },
                    { "SE2626", "R033", "G6" },
                    { "SE2627", "R033", "G7" },
                    { "SE2628", "R033", "G8" },
                    { "SE2629", "R033", "G9" },
                    { "SE2630", "R033", "G10" },
                    { "SE2631", "R033", "H1" },
                    { "SE2632", "R033", "H2" },
                    { "SE2633", "R033", "H3" },
                    { "SE2634", "R033", "H4" },
                    { "SE2635", "R033", "H5" },
                    { "SE2636", "R033", "H6" },
                    { "SE2637", "R033", "H7" },
                    { "SE2638", "R033", "H8" },
                    { "SE2639", "R033", "H9" },
                    { "SE2640", "R033", "H10" },
                    { "SE2641", "R034", "A1" },
                    { "SE2642", "R034", "A2" },
                    { "SE2643", "R034", "A3" },
                    { "SE2644", "R034", "A4" },
                    { "SE2645", "R034", "A5" },
                    { "SE2646", "R034", "A6" },
                    { "SE2647", "R034", "A7" },
                    { "SE2648", "R034", "A8" },
                    { "SE2649", "R034", "A9" },
                    { "SE2650", "R034", "A10" },
                    { "SE2651", "R034", "B1" },
                    { "SE2652", "R034", "B2" },
                    { "SE2653", "R034", "B3" },
                    { "SE2654", "R034", "B4" },
                    { "SE2655", "R034", "B5" },
                    { "SE2656", "R034", "B6" },
                    { "SE2657", "R034", "B7" },
                    { "SE2658", "R034", "B8" },
                    { "SE2659", "R034", "B9" },
                    { "SE2660", "R034", "B10" },
                    { "SE2661", "R034", "C1" },
                    { "SE2662", "R034", "C2" },
                    { "SE2663", "R034", "C3" },
                    { "SE2664", "R034", "C4" },
                    { "SE2665", "R034", "C5" },
                    { "SE2666", "R034", "C6" },
                    { "SE2667", "R034", "C7" },
                    { "SE2668", "R034", "C8" },
                    { "SE2669", "R034", "C9" },
                    { "SE2670", "R034", "C10" },
                    { "SE2671", "R034", "D1" },
                    { "SE2672", "R034", "D2" },
                    { "SE2673", "R034", "D3" },
                    { "SE2674", "R034", "D4" },
                    { "SE2675", "R034", "D5" },
                    { "SE2676", "R034", "D6" },
                    { "SE2677", "R034", "D7" },
                    { "SE2678", "R034", "D8" },
                    { "SE2679", "R034", "D9" },
                    { "SE2680", "R034", "D10" },
                    { "SE2681", "R034", "E1" },
                    { "SE2682", "R034", "E2" },
                    { "SE2683", "R034", "E3" },
                    { "SE2684", "R034", "E4" },
                    { "SE2685", "R034", "E5" },
                    { "SE2686", "R034", "E6" },
                    { "SE2687", "R034", "E7" },
                    { "SE2688", "R034", "E8" },
                    { "SE2689", "R034", "E9" },
                    { "SE2690", "R034", "E10" },
                    { "SE2691", "R034", "F1" },
                    { "SE2692", "R034", "F2" },
                    { "SE2693", "R034", "F3" },
                    { "SE2694", "R034", "F4" },
                    { "SE2695", "R034", "F5" },
                    { "SE2696", "R034", "F6" },
                    { "SE2697", "R034", "F7" },
                    { "SE2698", "R034", "F8" },
                    { "SE2699", "R034", "F9" },
                    { "SE2700", "R034", "F10" },
                    { "SE2701", "R034", "G1" },
                    { "SE2702", "R034", "G2" },
                    { "SE2703", "R034", "G3" },
                    { "SE2704", "R034", "G4" },
                    { "SE2705", "R034", "G5" },
                    { "SE2706", "R034", "G6" },
                    { "SE2707", "R034", "G7" },
                    { "SE2708", "R034", "G8" },
                    { "SE2709", "R034", "G9" },
                    { "SE2710", "R034", "G10" },
                    { "SE2711", "R034", "H1" },
                    { "SE2712", "R034", "H2" },
                    { "SE2713", "R034", "H3" },
                    { "SE2714", "R034", "H4" },
                    { "SE2715", "R034", "H5" },
                    { "SE2716", "R034", "H6" },
                    { "SE2717", "R034", "H7" },
                    { "SE2718", "R034", "H8" },
                    { "SE2719", "R034", "H9" },
                    { "SE2720", "R034", "H10" }
                });

            migrationBuilder.InsertData(
                table: "Showtimes",
                columns: new[] { "ShowtimeId", "CreatedAt", "EndTime", "MovieId", "RoomId", "StartTime", "Status", "UpdatedAt" },
                values: new object[,]
                {
                    { "ST101", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 22, 12, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R031", new DateTime(2026, 6, 22, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST102", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 22, 16, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R032", new DateTime(2026, 6, 22, 14, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST103", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 22, 20, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R033", new DateTime(2026, 6, 22, 18, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST104", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 22, 17, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R034", new DateTime(2026, 6, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "ShowtimeTicketTypes",
                columns: new[] { "ShowtimeTicketTypeId", "Price", "ShowtimeId", "TicketTypeId" },
                values: new object[,]
                {
                    { "STT101", 80000.0, "ST101", "TT001" },
                    { "STT102", 80000.0, "ST102", "TT001" },
                    { "STT103", 80000.0, "ST103", "TT001" },
                    { "STT104", 80000.0, "ST104", "TT001" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2401");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2402");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2403");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2404");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2405");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2406");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2407");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2408");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2409");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2410");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2411");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2412");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2413");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2414");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2415");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2416");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2417");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2418");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2419");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2420");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2421");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2422");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2423");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2424");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2425");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2426");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2427");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2428");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2429");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2430");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2431");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2432");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2433");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2434");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2435");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2436");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2437");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2438");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2439");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2440");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2441");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2442");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2443");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2444");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2445");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2446");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2447");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2448");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2449");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2450");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2451");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2452");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2453");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2454");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2455");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2456");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2457");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2458");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2459");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2460");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2461");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2462");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2463");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2464");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2465");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2466");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2467");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2468");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2469");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2470");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2471");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2472");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2473");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2474");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2475");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2476");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2477");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2478");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2479");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2480");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2481");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2482");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2483");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2484");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2485");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2486");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2487");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2488");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2489");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2490");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2491");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2492");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2493");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2494");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2495");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2496");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2497");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2498");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2499");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2500");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2501");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2502");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2503");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2504");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2505");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2506");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2507");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2508");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2509");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2510");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2511");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2512");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2513");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2514");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2515");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2516");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2517");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2518");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2519");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2520");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2521");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2522");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2523");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2524");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2525");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2526");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2527");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2528");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2529");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2530");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2531");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2532");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2533");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2534");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2535");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2536");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2537");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2538");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2539");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2540");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2541");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2542");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2543");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2544");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2545");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2546");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2547");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2548");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2549");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2550");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2551");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2552");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2553");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2554");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2555");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2556");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2557");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2558");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2559");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2560");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2561");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2562");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2563");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2564");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2565");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2566");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2567");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2568");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2569");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2570");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2571");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2572");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2573");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2574");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2575");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2576");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2577");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2578");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2579");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2580");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2581");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2582");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2583");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2584");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2585");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2586");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2587");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2588");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2589");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2590");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2591");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2592");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2593");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2594");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2595");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2596");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2597");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2598");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2599");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2600");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2601");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2602");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2603");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2604");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2605");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2606");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2607");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2608");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2609");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2610");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2611");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2612");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2613");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2614");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2615");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2616");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2617");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2618");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2619");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2620");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2621");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2622");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2623");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2624");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2625");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2626");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2627");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2628");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2629");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2630");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2631");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2632");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2633");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2634");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2635");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2636");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2637");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2638");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2639");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2640");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2641");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2642");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2643");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2644");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2645");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2646");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2647");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2648");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2649");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2650");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2651");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2652");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2653");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2654");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2655");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2656");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2657");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2658");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2659");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2660");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2661");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2662");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2663");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2664");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2665");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2666");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2667");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2668");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2669");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2670");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2671");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2672");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2673");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2674");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2675");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2676");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2677");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2678");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2679");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2680");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2681");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2682");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2683");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2684");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2685");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2686");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2687");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2688");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2689");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2690");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2691");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2692");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2693");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2694");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2695");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2696");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2697");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2698");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2699");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2700");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2701");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2702");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2703");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2704");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2705");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2706");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2707");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2708");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2709");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2710");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2711");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2712");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2713");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2714");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2715");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2716");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2717");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2718");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2719");

            migrationBuilder.DeleteData(
                table: "Seats",
                keyColumn: "SeatId",
                keyValue: "SE2720");

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
                table: "Rooms",
                keyColumn: "RoomId",
                keyValue: "R031");

            migrationBuilder.DeleteData(
                table: "Rooms",
                keyColumn: "RoomId",
                keyValue: "R032");

            migrationBuilder.DeleteData(
                table: "Rooms",
                keyColumn: "RoomId",
                keyValue: "R033");

            migrationBuilder.DeleteData(
                table: "Rooms",
                keyColumn: "RoomId",
                keyValue: "R034");

            migrationBuilder.DeleteData(
                table: "Cinemas",
                keyColumn: "CinemaId",
                keyValue: "C007");

            migrationBuilder.DeleteData(
                table: "Cinemas",
                keyColumn: "CinemaId",
                keyValue: "C008");

            migrationBuilder.DeleteData(
                table: "Cinemas",
                keyColumn: "CinemaId",
                keyValue: "C009");

            migrationBuilder.DeleteData(
                table: "Cinemas",
                keyColumn: "CinemaId",
                keyValue: "C010");

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
        }
    }
}
