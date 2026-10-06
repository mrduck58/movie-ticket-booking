using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Movie_Ticket_Booking_Backend.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Casts",
                columns: table => new
                {
                    CastId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AvatarUrl = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Casts", x => x.CastId);
                });

            migrationBuilder.CreateTable(
                name: "Cinemas",
                columns: table => new
                {
                    CinemaId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Location = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Rating = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Hotline = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cinemas", x => x.CinemaId);
                });

            migrationBuilder.CreateTable(
                name: "FoodCombos",
                columns: table => new
                {
                    FoodComboId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FoodCombos", x => x.FoodComboId);
                });

            migrationBuilder.CreateTable(
                name: "Genres",
                columns: table => new
                {
                    GenreId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Genres", x => x.GenreId);
                });

            migrationBuilder.CreateTable(
                name: "Movies",
                columns: table => new
                {
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TitleVn = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TrailerUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Duration = table.Column<double>(type: "float", nullable: false),
                    Rating = table.Column<double>(type: "float", nullable: false),
                    Director = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Movies", x => x.MovieId);
                });

            migrationBuilder.CreateTable(
                name: "PaymentMethods",
                columns: table => new
                {
                    PaymentMethodId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaymentMethods", x => x.PaymentMethodId);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Roles", x => x.RoleId);
                });

            migrationBuilder.CreateTable(
                name: "TicketTypes",
                columns: table => new
                {
                    TicketTypeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TicketTypes", x => x.TicketTypeId);
                });

            migrationBuilder.CreateTable(
                name: "Vouchers",
                columns: table => new
                {
                    VoucherId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Code = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Type = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Value = table.Column<double>(type: "float", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ExpiredDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vouchers", x => x.VoucherId);
                });

            migrationBuilder.CreateTable(
                name: "Rooms",
                columns: table => new
                {
                    RoomId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CinemaId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rooms", x => x.RoomId);
                    table.ForeignKey(
                        name: "FK_Rooms_Cinemas_CinemaId",
                        column: x => x.CinemaId,
                        principalTable: "Cinemas",
                        principalColumn: "CinemaId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MovieCasts",
                columns: table => new
                {
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CastId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CharacterName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CharacterAvatar = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MovieCasts", x => new { x.MovieId, x.CastId });
                    table.ForeignKey(
                        name: "FK_MovieCasts_Casts_CastId",
                        column: x => x.CastId,
                        principalTable: "Casts",
                        principalColumn: "CastId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_MovieCasts_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MovieGenres",
                columns: table => new
                {
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    GenreId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MovieGenres", x => new { x.MovieId, x.GenreId });
                    table.ForeignKey(
                        name: "FK_MovieGenres_Genres_GenreId",
                        column: x => x.GenreId,
                        principalTable: "Genres",
                        principalColumn: "GenreId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_MovieGenres_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Posters",
                columns: table => new
                {
                    PosterId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Posters", x => x.PosterId);
                    table.ForeignKey(
                        name: "FK_Posters_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FullName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AvatarUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Gender = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CCCD = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Hometown = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.UserId);
                    table.ForeignKey(
                        name: "FK_Users_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "RoleId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Seats",
                columns: table => new
                {
                    SeatId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    SeatName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RoomId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Seats", x => x.SeatId);
                    table.ForeignKey(
                        name: "FK_Seats_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "RoomId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Showtimes",
                columns: table => new
                {
                    ShowtimeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    StartTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    RoomId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Showtimes", x => x.ShowtimeId);
                    table.ForeignKey(
                        name: "FK_Showtimes_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Showtimes_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalTable: "Rooms",
                        principalColumn: "RoomId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "BlogPosts",
                columns: table => new
                {
                    BlogPostId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Likes = table.Column<int>(type: "int", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BlogPosts", x => x.BlogPostId);
                    table.ForeignKey(
                        name: "FK_BlogPosts_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MovieRatings",
                columns: table => new
                {
                    MovieRatingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Stars = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MovieRatings", x => x.MovieRatingId);
                    table.ForeignKey(
                        name: "FK_MovieRatings_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_MovieRatings_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "UserGenres",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    GenreId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserGenres", x => new { x.UserId, x.GenreId });
                    table.ForeignKey(
                        name: "FK_UserGenres_Genres_GenreId",
                        column: x => x.GenreId,
                        principalTable: "Genres",
                        principalColumn: "GenreId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_UserGenres_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "UserVouchers",
                columns: table => new
                {
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    VoucherId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserVoucherId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UsedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserVouchers", x => new { x.UserId, x.VoucherId });
                    table.ForeignKey(
                        name: "FK_UserVouchers_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_UserVouchers_Vouchers_VoucherId",
                        column: x => x.VoucherId,
                        principalTable: "Vouchers",
                        principalColumn: "VoucherId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "WatchLists",
                columns: table => new
                {
                    WatchListId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    MovieId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    type = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WatchLists", x => x.WatchListId);
                    table.ForeignKey(
                        name: "FK_WatchLists_Movies_MovieId",
                        column: x => x.MovieId,
                        principalTable: "Movies",
                        principalColumn: "MovieId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_WatchLists_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Bookings",
                columns: table => new
                {
                    BookingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ShowtimeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    TotalAmount = table.Column<double>(type: "float", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OrderCode = table.Column<long>(type: "bigint", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Bookings", x => x.BookingId);
                    table.ForeignKey(
                        name: "FK_Bookings_Showtimes_ShowtimeId",
                        column: x => x.ShowtimeId,
                        principalTable: "Showtimes",
                        principalColumn: "ShowtimeId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Bookings_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "SeatLocks",
                columns: table => new
                {
                    SeatLockId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ShowtimeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    SeatId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    LockedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ExpiredAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SeatLocks", x => x.SeatLockId);
                    table.ForeignKey(
                        name: "FK_SeatLocks_Seats_SeatId",
                        column: x => x.SeatId,
                        principalTable: "Seats",
                        principalColumn: "SeatId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SeatLocks_Showtimes_ShowtimeId",
                        column: x => x.ShowtimeId,
                        principalTable: "Showtimes",
                        principalColumn: "ShowtimeId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SeatLocks_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ShowtimeTicketTypes",
                columns: table => new
                {
                    ShowtimeTicketTypeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ShowtimeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    TicketTypeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ShowtimeTicketTypes", x => x.ShowtimeTicketTypeId);
                    table.ForeignKey(
                        name: "FK_ShowtimeTicketTypes_Showtimes_ShowtimeId",
                        column: x => x.ShowtimeId,
                        principalTable: "Showtimes",
                        principalColumn: "ShowtimeId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_ShowtimeTicketTypes_TicketTypes_TicketTypeId",
                        column: x => x.TicketTypeId,
                        principalTable: "TicketTypes",
                        principalColumn: "TicketTypeId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Comments",
                columns: table => new
                {
                    CommentId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    BlogPostId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comments", x => x.CommentId);
                    table.ForeignKey(
                        name: "FK_Comments_BlogPosts_BlogPostId",
                        column: x => x.BlogPostId,
                        principalTable: "BlogPosts",
                        principalColumn: "BlogPostId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Comments_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PostLikes",
                columns: table => new
                {
                    PostLikeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    BlogPostId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PostLikes", x => x.PostLikeId);
                    table.ForeignKey(
                        name: "FK_PostLikes_BlogPosts_BlogPostId",
                        column: x => x.BlogPostId,
                        principalTable: "BlogPosts",
                        principalColumn: "BlogPostId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_PostLikes_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "BookingFoodCombos",
                columns: table => new
                {
                    BookingFoodComboId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    BookingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    FoodComboId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BookingFoodCombos", x => x.BookingFoodComboId);
                    table.ForeignKey(
                        name: "FK_BookingFoodCombos_Bookings_BookingId",
                        column: x => x.BookingId,
                        principalTable: "Bookings",
                        principalColumn: "BookingId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BookingFoodCombos_FoodCombos_FoodComboId",
                        column: x => x.FoodComboId,
                        principalTable: "FoodCombos",
                        principalColumn: "FoodComboId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "BookingVouchers",
                columns: table => new
                {
                    BookingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    VoucherId = table.Column<string>(type: "nvarchar(450)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BookingVouchers", x => new { x.BookingId, x.VoucherId });
                    table.ForeignKey(
                        name: "FK_BookingVouchers_Bookings_BookingId",
                        column: x => x.BookingId,
                        principalTable: "Bookings",
                        principalColumn: "BookingId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BookingVouchers_Vouchers_VoucherId",
                        column: x => x.VoucherId,
                        principalTable: "Vouchers",
                        principalColumn: "VoucherId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Payments",
                columns: table => new
                {
                    PaymentId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    BookingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    PaymentMethodId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Amount = table.Column<double>(type: "float", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Payments", x => x.PaymentId);
                    table.ForeignKey(
                        name: "FK_Payments_Bookings_BookingId",
                        column: x => x.BookingId,
                        principalTable: "Bookings",
                        principalColumn: "BookingId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Payments_PaymentMethods_PaymentMethodId",
                        column: x => x.PaymentMethodId,
                        principalTable: "PaymentMethods",
                        principalColumn: "PaymentMethodId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "BookingSeats",
                columns: table => new
                {
                    BookingSeatId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    BookingId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    SeatId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    ShowtimeTicketTypeId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Price = table.Column<double>(type: "float", nullable: false),
                    QrCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CheckinTime = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BookingSeats", x => x.BookingSeatId);
                    table.ForeignKey(
                        name: "FK_BookingSeats_Bookings_BookingId",
                        column: x => x.BookingId,
                        principalTable: "Bookings",
                        principalColumn: "BookingId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BookingSeats_Seats_SeatId",
                        column: x => x.SeatId,
                        principalTable: "Seats",
                        principalColumn: "SeatId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_BookingSeats_ShowtimeTicketTypes_ShowtimeTicketTypeId",
                        column: x => x.ShowtimeTicketTypeId,
                        principalTable: "ShowtimeTicketTypes",
                        principalColumn: "ShowtimeTicketTypeId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Notifications",
                columns: table => new
                {
                    NotificationId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    WatchListId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    BlogPostId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    CommentId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    BookingSeatId = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    Type = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Message = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsRead = table.Column<bool>(type: "bit", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notifications", x => x.NotificationId);
                    table.ForeignKey(
                        name: "FK_Notifications_BlogPosts_BlogPostId",
                        column: x => x.BlogPostId,
                        principalTable: "BlogPosts",
                        principalColumn: "BlogPostId",
                        onDelete: ReferentialAction.SetNull);
                    table.ForeignKey(
                        name: "FK_Notifications_BookingSeats_BookingSeatId",
                        column: x => x.BookingSeatId,
                        principalTable: "BookingSeats",
                        principalColumn: "BookingSeatId",
                        onDelete: ReferentialAction.SetNull);
                    table.ForeignKey(
                        name: "FK_Notifications_Comments_CommentId",
                        column: x => x.CommentId,
                        principalTable: "Comments",
                        principalColumn: "CommentId",
                        onDelete: ReferentialAction.SetNull);
                    table.ForeignKey(
                        name: "FK_Notifications_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Notifications_WatchLists_WatchListId",
                        column: x => x.WatchListId,
                        principalTable: "WatchLists",
                        principalColumn: "WatchListId",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.InsertData(
                table: "Casts",
                columns: new[] { "CastId", "AvatarUrl", "Name" },
                values: new object[,]
                {
                    { "CAST001", "https://image.tmdb.org/t/p/w500/1YjdSym1jTG7xjHSI0yGGWEsw5i.jpg", "Robert Downey Jr." },
                    { "CAST002", "https://image.tmdb.org/t/p/w500/3bOGNsHlrswhyW79uvIHH1V43JI.jpg", "Chris Evans" },
                    { "CAST003", "https://image.tmdb.org/t/p/w500/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg", "Scarlett Johansson" },
                    { "CAST004", "https://image.tmdb.org/t/p/w500/2qhIDp44cAqP2clOgt2afQI07X8.jpg", "Tom Holland" },
                    { "CAST005", "https://image.tmdb.org/t/p/w500/soCzE1b0E4W3F7h2mXc4L0bXc2n.jpg", "Zendaya" },
                    { "CAST006", "https://image.tmdb.org/t/p/w500/8A4PS5iG7GWEAVFftyqMZKl3lbA.jpg", "Robert Pattinson" },
                    { "CAST007", "https://image.tmdb.org/t/p/w500/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg", "Zoe Kravitz" },
                    { "CAST008", "https://image.tmdb.org/t/p/w500/fBEucxECxGLKVHBznO0qHtCGiMO.jpg", "Benedict Cumberbatch" },
                    { "CAST009", "https://image.tmdb.org/t/p/w500/wIU675y4lOQMj2mc7vo5Wy7Z8bZ.jpg", "Elizabeth Olsen" },
                    { "CAST010", "https://image.tmdb.org/t/p/w500/4SYTH5FdB0dAORV98Nwg3llgVnY.jpg", "Ryan Reynolds" }
                });

            migrationBuilder.InsertData(
                table: "Cinemas",
                columns: new[] { "CinemaId", "CreatedAt", "Hotline", "Location", "Name", "Rating", "UpdatedAt" },
                values: new object[,]
                {
                    { "C001", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "19006017", "Ha Noi", "CGV Vincom Ba Trieu", "4.5", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "C002", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "1900558899", "Ha Noi", "Lotte Cinema Landmark", "4.6", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "C003", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "19002099", "Ha Noi", "BHD Star Pham Ngoc Thach", "4.4", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "FoodCombos",
                columns: new[] { "FoodComboId", "CreatedDate", "Description", "ImageUrl", "Name", "Price", "Status", "UpdatedDate" },
                values: new object[,]
                {
                    { "FC001", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "1 Large Popcorn + 1 Coke", "https://www.bhdstar.vn/wp-content/uploads/2025/06/SINGLE-COMBO-1-1.jpg", "Popcorn + Coke", 75000.0, "ACTIVE", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "FC002", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "1 Large Popcorn + 2 Drinks", "https://www.bhdstar.vn/wp-content/uploads/2025/06/COUPLE-COMBO-1-1.jpg", "Couple Combo", 120000.0, "ACTIVE", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "FC003", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "2 Large Popcorn + 4 Drinks", "https://www.bhdstar.vn/wp-content/uploads/2025/05/TRA-3-VI-2-1.jpg", "Family Combo", 200000.0, "ACTIVE", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "FC004", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Nachos + 1 Coke", "https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56", "Nachos Combo", 85000.0, "ACTIVE", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Genres",
                columns: new[] { "GenreId", "CreatedAt", "Name", "UpdatedAt" },
                values: new object[,]
                {
                    { "GEN001", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Action", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN002", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Adventure", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN003", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Animation", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN004", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Biography", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN005", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Comedy", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN006", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Crime", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN007", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Documentary", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN008", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Drama", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN009", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Family", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN010", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Fantasy", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN011", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "History", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN012", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Horror", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN013", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Music", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN014", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Mystery", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN015", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Romance", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN016", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sci-Fi", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN017", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sport", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN018", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Thriller", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN019", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "War", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN020", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Western", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN021", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Superhero", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN022", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Psychological", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN023", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Anime", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN024", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Disaster", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "GEN025", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Martial Arts", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Movies",
                columns: new[] { "MovieId", "CreatedAt", "Description", "Director", "Duration", "Rating", "Status", "Title", "TitleVn", "TrailerUrl", "UpdatedAt" },
                values: new object[,]
                {
                    { "MOV001", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "The Avengers assemble for the final battle against Thanos.", "Anthony Russo, Joe Russo", 181.0, 8.4000000000000004, "NOWSHOWING", "Avengers: Endgame", "Biệt Đội Siêu Anh Hùng: Hồi Kết", "https://www.youtube.com/watch?v=TcMBFSGVi1c", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV002", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Spider-Man faces villains from different universes.", "Jon Watts", 148.0, 8.1999999999999993, "NOWSHOWING", "Spider-Man: No Way Home", "Người Nhện: Không Còn Nhà", "https://www.youtube.com/watch?v=JfVOs4VSpmA", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV003", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Batman investigates corruption in Gotham.", "d8", 176.0, 7.9000000000000004, "NOWSHOWING", "The Batman", "Người Dơi", "https://www.youtube.com/watch?v=mqqft2x_Aa4", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV004", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Doctor Strange explores the multiverse.", "d7", 126.0, 7.0, "NOWSHOWING", "Doctor Strange in the Multiverse of Madness", "Phù Thủy Tối Thượng: Đa Vũ Trụ Hỗn Loạn", "https://www.youtube.com/watch?v=aWzlQ2N6qqg", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV005", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Deadpool meets Wolverine in a chaotic adventure.", "d6", 130.0, 0.0, "COMINGSOON", "Deadpool & Wolverine", "Deadpool & Wolverine", "https://www.youtube.com/watch?v=73_1biulkYk", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV006", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Arthur Fleck continues his descent into madness.", "d5", 138.0, 0.0, "COMINGSOON", "Joker: Folie à Deux", "Joker: Điên Cuồng Hai Người", "https://www.youtube.com/watch?v=xy8aJw1vYHo", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV007", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Po trains a new dragon warrior.", "d4", 95.0, 0.0, "COMINGSOON", "Kung Fu Panda 4", "Kung Fu Panda 4", "https://www.youtube.com/watch?v=_inKs4eeHiI", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV008", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ethan Hunt returns for his most dangerous mission.", "d3", 160.0, 0.0, "COMINGSOON", "Mission Impossible 8", "Nhiệm Vụ Bất Khả Thi 8", "https://www.youtube.com/watch?v=avz06PDqDbM", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV009", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Jake Sully protects his family on Pandora.", "d2", 192.0, 7.7000000000000002, "NOWSHOWING", "Avatar: The Way of Water", "Avatar: Dòng Chảy Của Nước", "https://www.youtube.com/watch?v=d9MyW72ELq0", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "MOV010", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Maverick trains a new generation of pilots.", "d1", 131.0, 8.3000000000000007, "NOWSHOWING", "Top Gun: Maverick", "Top Gun: Maverick", "https://www.youtube.com/watch?v=giXco2jaZ_4", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "PaymentMethods",
                columns: new[] { "PaymentMethodId", "CreatedDate", "ImageUrl", "Name", "Status", "UpdatedDate" },
                values: new object[,]
                {
                    { "PM001", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4776), "https://example.com/creditcard.png", "Credit Card", "ACTIVE", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4785) },
                    { "PM002", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4787), "https://example.com/momo.png", "Momo", "ACTIVE", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4788) },
                    { "PM003", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4790), "https://example.com/zalopay.png", "ZaloPay", "ACTIVE", new DateTime(2026, 3, 27, 23, 46, 24, 291, DateTimeKind.Local).AddTicks(4791) }
                });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "RoleId", "Name" },
                values: new object[,]
                {
                    { "ROLE001", "ADMIN" },
                    { "ROLE002", "CUSTOMER" }
                });

            migrationBuilder.InsertData(
                table: "TicketTypes",
                columns: new[] { "TicketTypeId", "Name", "Status" },
                values: new object[,]
                {
                    { "TT001", "Standard", "ACTIVE" },
                    { "TT002", "IMAX", "ACTIVE" },
                    { "TT003", "Dolby Cinema", "ACTIVE" }
                });

            migrationBuilder.InsertData(
                table: "Vouchers",
                columns: new[] { "VoucherId", "Code", "CreatedDate", "Description", "ExpiredDate", "Status", "Title", "Type", "Value" },
                values: new object[,]
                {
                    { "VC001", "WELCOME10", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "10% discount for new users", new DateTime(2027, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ACTIVE", "Welcome Discount", "PERCENTAGE", 10.0 },
                    { "VC002", "MOVIE50K", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Get 50,000 VND discount on booking", new DateTime(2027, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ACTIVE", "50K Off", "FIX_AMOUNT", 50000.0 },
                    { "VC003", "WEEKEND20", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "20% off for weekend bookings", new DateTime(2027, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ACTIVE", "Weekend Discount", "PERCENTAGE", 20.0 },
                    { "VC004", "STUDENT15", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "15% discount for students", new DateTime(2027, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ACTIVE", "Student Offer", "PERCENTAGE", 15.0 },
                    { "VC005", "COMBO30", new DateTime(2024, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "30% off when buying food combo", new DateTime(2027, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ACTIVE", "Combo Discount", "PERCENTAGE", 30.0 }
                });

            migrationBuilder.InsertData(
                table: "MovieCasts",
                columns: new[] { "CastId", "MovieId", "CharacterAvatar", "CharacterName" },
                values: new object[,]
                {
                    { "CAST001", "MOV001", "", "Iron Man" },
                    { "CAST002", "MOV001", "", "Captain America" },
                    { "CAST003", "MOV001", "", "Black Widow" },
                    { "CAST004", "MOV002", "", "Spider-Man" },
                    { "CAST005", "MOV002", "", "MJ" },
                    { "CAST006", "MOV003", "", "Batman" },
                    { "CAST007", "MOV003", "", "Catwoman" },
                    { "CAST008", "MOV004", "", "Doctor Strange" },
                    { "CAST009", "MOV004", "", "Scarlet Witch" },
                    { "CAST010", "MOV005", "", "Deadpool" }
                });

            migrationBuilder.InsertData(
                table: "MovieGenres",
                columns: new[] { "GenreId", "MovieId" },
                values: new object[,]
                {
                    { "GEN001", "MOV001" },
                    { "GEN016", "MOV001" },
                    { "GEN021", "MOV001" },
                    { "GEN002", "MOV002" },
                    { "GEN010", "MOV002" },
                    { "GEN008", "MOV003" },
                    { "GEN015", "MOV003" },
                    { "GEN012", "MOV004" },
                    { "GEN018", "MOV004" },
                    { "GEN005", "MOV005" },
                    { "GEN009", "MOV005" },
                    { "GEN016", "MOV006" },
                    { "GEN018", "MOV006" },
                    { "GEN001", "MOV007" },
                    { "GEN002", "MOV007" },
                    { "GEN003", "MOV008" },
                    { "GEN023", "MOV008" },
                    { "GEN004", "MOV009" },
                    { "GEN008", "MOV009" },
                    { "GEN018", "MOV010" },
                    { "GEN024", "MOV010" }
                });

            migrationBuilder.InsertData(
                table: "Posters",
                columns: new[] { "PosterId", "ImageUrl", "MovieId", "Title" },
                values: new object[,]
                {
                    { "POS001", "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg", "MOV001", "Avengers Poster" },
                    { "POS002", "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", "MOV002", "Spider-Man Poster" },
                    { "POS003", "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg", "MOV003", "Batman Poster" },
                    { "POS004", "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", "MOV004", "Doctor Strange Poster" },
                    { "POS005", "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg", "MOV005", "Deadpool Poster" },
                    { "POS006", "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg", "MOV006", "Joker Poster" },
                    { "POS007", "https://image.tmdb.org/t/p/w500/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg", "MOV007", "Kung Fu Panda Poster" },
                    { "POS008", "https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg", "MOV008", "Mission Impossible Poster" },
                    { "POS009", "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg", "MOV009", "Avatar Poster" },
                    { "POS010", "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg", "MOV010", "Top Gun Poster" }
                });

            migrationBuilder.InsertData(
                table: "Rooms",
                columns: new[] { "RoomId", "CinemaId", "Name" },
                values: new object[,]
                {
                    { "R001", "C001", "Auditorium 1" },
                    { "R002", "C001", "Auditorium 2" },
                    { "R003", "C001", "Auditorium 3" },
                    { "R004", "C001", "Auditorium 4" },
                    { "R005", "C001", "Auditorium 5" },
                    { "R006", "C002", "Auditorium 1" },
                    { "R007", "C002", "Auditorium 2" },
                    { "R008", "C002", "Auditorium 3" },
                    { "R009", "C002", "Auditorium 4" },
                    { "R010", "C002", "Auditorium 5" },
                    { "R011", "C003", "Auditorium 1" },
                    { "R012", "C003", "Auditorium 2" },
                    { "R013", "C003", "Auditorium 3" },
                    { "R014", "C003", "Auditorium 4" },
                    { "R015", "C003", "Auditorium 5" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "UserId", "Address", "AvatarUrl", "CCCD", "CreatedAt", "DateOfBirth", "Email", "FullName", "Gender", "Hometown", "PasswordHash", "Phone", "RoleId", "Status", "UpdatedAt" },
                values: new object[,]
                {
                    { "USR001", null, "https://i.pravatar.cc/150?img=1", null, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "john@example.com", "John Smith", null, null, "123456", "0900000001", "ROLE002", "ACTIVE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "USR002", null, "https://i.pravatar.cc/150?img=2", null, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "emma@example.com", "Emma Watson", null, null, "123456", "0900000002", "ROLE002", "ACTIVE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "USR003", null, "https://i.pravatar.cc/150?img=3", null, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "robert@example.com", "Robert Downey Jr", null, null, "123456", "0900000003", "ROLE002", "ACTIVE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "USR004", null, "https://i.pravatar.cc/150?img=4", null, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "scarlett@example.com", "Scarlett Johansson", null, null, "123456", "0900000004", "ROLE002", "ACTIVE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "USR005", null, "https://i.pravatar.cc/150?img=5", null, new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "chris@example.com", "Chris Evans", null, null, "123456", "0900000005", "ROLE002", "ACTIVE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "BlogPosts",
                columns: new[] { "BlogPostId", "Content", "CreatedDate", "ImageUrl", "Likes", "Title", "UserId" },
                values: new object[,]
                {
                    { "BLOG001", "Marvel movies have changed the superhero genre forever...", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://images.unsplash.com/photo-1", 120, "Top 10 Marvel Movies You Must Watch", "USR001" },
                    { "BLOG002", "Horror movies give audiences a thrilling experience...", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://images.unsplash.com/photo-2", 85, "Why Horror Movies Are So Popular", "USR002" },
                    { "BLOG003", "Science fiction movies explore the future and technology...", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://images.unsplash.com/photo-3", 95, "Best Sci-Fi Movies of the Decade", "USR003" },
                    { "BLOG004", "These romantic films will make your evening unforgettable...", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://images.unsplash.com/photo-4", 60, "Romantic Movies Perfect for Date Night", "USR004" },
                    { "BLOG005", "Many exciting movies are coming to theaters next year...", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://images.unsplash.com/photo-5", 150, "Upcoming Blockbusters in 2026", "USR005" }
                });

            migrationBuilder.InsertData(
                table: "MovieRatings",
                columns: new[] { "MovieRatingId", "MovieId", "Stars", "UserId" },
                values: new object[,]
                {
                    { "RAT001", "MOV001", 5, "USR001" },
                    { "RAT002", "MOV001", 4, "USR002" },
                    { "RAT003", "MOV002", 3, "USR003" },
                    { "RAT004", "MOV002", 5, "USR004" }
                });

            migrationBuilder.InsertData(
                table: "Seats",
                columns: new[] { "SeatId", "RoomId", "SeatName" },
                values: new object[,]
                {
                    { "SE0001", "R001", "A1" },
                    { "SE0002", "R001", "A2" },
                    { "SE0003", "R001", "A3" },
                    { "SE0004", "R001", "A4" },
                    { "SE0005", "R001", "A5" },
                    { "SE0006", "R001", "A6" },
                    { "SE0007", "R001", "A7" },
                    { "SE0008", "R001", "A8" },
                    { "SE0009", "R001", "A9" },
                    { "SE0010", "R001", "A10" },
                    { "SE0011", "R001", "B1" },
                    { "SE0012", "R001", "B2" },
                    { "SE0013", "R001", "B3" },
                    { "SE0014", "R001", "B4" },
                    { "SE0015", "R001", "B5" },
                    { "SE0016", "R001", "B6" },
                    { "SE0017", "R001", "B7" },
                    { "SE0018", "R001", "B8" },
                    { "SE0019", "R001", "B9" },
                    { "SE0020", "R001", "B10" },
                    { "SE0021", "R001", "C1" },
                    { "SE0022", "R001", "C2" },
                    { "SE0023", "R001", "C3" },
                    { "SE0024", "R001", "C4" },
                    { "SE0025", "R001", "C5" },
                    { "SE0026", "R001", "C6" },
                    { "SE0027", "R001", "C7" },
                    { "SE0028", "R001", "C8" },
                    { "SE0029", "R001", "C9" },
                    { "SE0030", "R001", "C10" },
                    { "SE0031", "R001", "D1" },
                    { "SE0032", "R001", "D2" },
                    { "SE0033", "R001", "D3" },
                    { "SE0034", "R001", "D4" },
                    { "SE0035", "R001", "D5" },
                    { "SE0036", "R001", "D6" },
                    { "SE0037", "R001", "D7" },
                    { "SE0038", "R001", "D8" },
                    { "SE0039", "R001", "D9" },
                    { "SE0040", "R001", "D10" },
                    { "SE0041", "R001", "E1" },
                    { "SE0042", "R001", "E2" },
                    { "SE0043", "R001", "E3" },
                    { "SE0044", "R001", "E4" },
                    { "SE0045", "R001", "E5" },
                    { "SE0046", "R001", "E6" },
                    { "SE0047", "R001", "E7" },
                    { "SE0048", "R001", "E8" },
                    { "SE0049", "R001", "E9" },
                    { "SE0050", "R001", "E10" },
                    { "SE0051", "R001", "F1" },
                    { "SE0052", "R001", "F2" },
                    { "SE0053", "R001", "F3" },
                    { "SE0054", "R001", "F4" },
                    { "SE0055", "R001", "F5" },
                    { "SE0056", "R001", "F6" },
                    { "SE0057", "R001", "F7" },
                    { "SE0058", "R001", "F8" },
                    { "SE0059", "R001", "F9" },
                    { "SE0060", "R001", "F10" },
                    { "SE0061", "R001", "G1" },
                    { "SE0062", "R001", "G2" },
                    { "SE0063", "R001", "G3" },
                    { "SE0064", "R001", "G4" },
                    { "SE0065", "R001", "G5" },
                    { "SE0066", "R001", "G6" },
                    { "SE0067", "R001", "G7" },
                    { "SE0068", "R001", "G8" },
                    { "SE0069", "R001", "G9" },
                    { "SE0070", "R001", "G10" },
                    { "SE0071", "R001", "H1" },
                    { "SE0072", "R001", "H2" },
                    { "SE0073", "R001", "H3" },
                    { "SE0074", "R001", "H4" },
                    { "SE0075", "R001", "H5" },
                    { "SE0076", "R001", "H6" },
                    { "SE0077", "R001", "H7" },
                    { "SE0078", "R001", "H8" },
                    { "SE0079", "R001", "H9" },
                    { "SE0080", "R001", "H10" },
                    { "SE0081", "R002", "A1" },
                    { "SE0082", "R002", "A2" },
                    { "SE0083", "R002", "A3" },
                    { "SE0084", "R002", "A4" },
                    { "SE0085", "R002", "A5" },
                    { "SE0086", "R002", "A6" },
                    { "SE0087", "R002", "A7" },
                    { "SE0088", "R002", "A8" },
                    { "SE0089", "R002", "A9" },
                    { "SE0090", "R002", "A10" },
                    { "SE0091", "R002", "B1" },
                    { "SE0092", "R002", "B2" },
                    { "SE0093", "R002", "B3" },
                    { "SE0094", "R002", "B4" },
                    { "SE0095", "R002", "B5" },
                    { "SE0096", "R002", "B6" },
                    { "SE0097", "R002", "B7" },
                    { "SE0098", "R002", "B8" },
                    { "SE0099", "R002", "B9" },
                    { "SE0100", "R002", "B10" },
                    { "SE0101", "R002", "C1" },
                    { "SE0102", "R002", "C2" },
                    { "SE0103", "R002", "C3" },
                    { "SE0104", "R002", "C4" },
                    { "SE0105", "R002", "C5" },
                    { "SE0106", "R002", "C6" },
                    { "SE0107", "R002", "C7" },
                    { "SE0108", "R002", "C8" },
                    { "SE0109", "R002", "C9" },
                    { "SE0110", "R002", "C10" },
                    { "SE0111", "R002", "D1" },
                    { "SE0112", "R002", "D2" },
                    { "SE0113", "R002", "D3" },
                    { "SE0114", "R002", "D4" },
                    { "SE0115", "R002", "D5" },
                    { "SE0116", "R002", "D6" },
                    { "SE0117", "R002", "D7" },
                    { "SE0118", "R002", "D8" },
                    { "SE0119", "R002", "D9" },
                    { "SE0120", "R002", "D10" },
                    { "SE0121", "R002", "E1" },
                    { "SE0122", "R002", "E2" },
                    { "SE0123", "R002", "E3" },
                    { "SE0124", "R002", "E4" },
                    { "SE0125", "R002", "E5" },
                    { "SE0126", "R002", "E6" },
                    { "SE0127", "R002", "E7" },
                    { "SE0128", "R002", "E8" },
                    { "SE0129", "R002", "E9" },
                    { "SE0130", "R002", "E10" },
                    { "SE0131", "R002", "F1" },
                    { "SE0132", "R002", "F2" },
                    { "SE0133", "R002", "F3" },
                    { "SE0134", "R002", "F4" },
                    { "SE0135", "R002", "F5" },
                    { "SE0136", "R002", "F6" },
                    { "SE0137", "R002", "F7" },
                    { "SE0138", "R002", "F8" },
                    { "SE0139", "R002", "F9" },
                    { "SE0140", "R002", "F10" },
                    { "SE0141", "R002", "G1" },
                    { "SE0142", "R002", "G2" },
                    { "SE0143", "R002", "G3" },
                    { "SE0144", "R002", "G4" },
                    { "SE0145", "R002", "G5" },
                    { "SE0146", "R002", "G6" },
                    { "SE0147", "R002", "G7" },
                    { "SE0148", "R002", "G8" },
                    { "SE0149", "R002", "G9" },
                    { "SE0150", "R002", "G10" },
                    { "SE0151", "R002", "H1" },
                    { "SE0152", "R002", "H2" },
                    { "SE0153", "R002", "H3" },
                    { "SE0154", "R002", "H4" },
                    { "SE0155", "R002", "H5" },
                    { "SE0156", "R002", "H6" },
                    { "SE0157", "R002", "H7" },
                    { "SE0158", "R002", "H8" },
                    { "SE0159", "R002", "H9" },
                    { "SE0160", "R002", "H10" },
                    { "SE0161", "R003", "A1" },
                    { "SE0162", "R003", "A2" },
                    { "SE0163", "R003", "A3" },
                    { "SE0164", "R003", "A4" },
                    { "SE0165", "R003", "A5" },
                    { "SE0166", "R003", "A6" },
                    { "SE0167", "R003", "A7" },
                    { "SE0168", "R003", "A8" },
                    { "SE0169", "R003", "A9" },
                    { "SE0170", "R003", "A10" },
                    { "SE0171", "R003", "B1" },
                    { "SE0172", "R003", "B2" },
                    { "SE0173", "R003", "B3" },
                    { "SE0174", "R003", "B4" },
                    { "SE0175", "R003", "B5" },
                    { "SE0176", "R003", "B6" },
                    { "SE0177", "R003", "B7" },
                    { "SE0178", "R003", "B8" },
                    { "SE0179", "R003", "B9" },
                    { "SE0180", "R003", "B10" },
                    { "SE0181", "R003", "C1" },
                    { "SE0182", "R003", "C2" },
                    { "SE0183", "R003", "C3" },
                    { "SE0184", "R003", "C4" },
                    { "SE0185", "R003", "C5" },
                    { "SE0186", "R003", "C6" },
                    { "SE0187", "R003", "C7" },
                    { "SE0188", "R003", "C8" },
                    { "SE0189", "R003", "C9" },
                    { "SE0190", "R003", "C10" },
                    { "SE0191", "R003", "D1" },
                    { "SE0192", "R003", "D2" },
                    { "SE0193", "R003", "D3" },
                    { "SE0194", "R003", "D4" },
                    { "SE0195", "R003", "D5" },
                    { "SE0196", "R003", "D6" },
                    { "SE0197", "R003", "D7" },
                    { "SE0198", "R003", "D8" },
                    { "SE0199", "R003", "D9" },
                    { "SE0200", "R003", "D10" },
                    { "SE0201", "R003", "E1" },
                    { "SE0202", "R003", "E2" },
                    { "SE0203", "R003", "E3" },
                    { "SE0204", "R003", "E4" },
                    { "SE0205", "R003", "E5" },
                    { "SE0206", "R003", "E6" },
                    { "SE0207", "R003", "E7" },
                    { "SE0208", "R003", "E8" },
                    { "SE0209", "R003", "E9" },
                    { "SE0210", "R003", "E10" },
                    { "SE0211", "R003", "F1" },
                    { "SE0212", "R003", "F2" },
                    { "SE0213", "R003", "F3" },
                    { "SE0214", "R003", "F4" },
                    { "SE0215", "R003", "F5" },
                    { "SE0216", "R003", "F6" },
                    { "SE0217", "R003", "F7" },
                    { "SE0218", "R003", "F8" },
                    { "SE0219", "R003", "F9" },
                    { "SE0220", "R003", "F10" },
                    { "SE0221", "R003", "G1" },
                    { "SE0222", "R003", "G2" },
                    { "SE0223", "R003", "G3" },
                    { "SE0224", "R003", "G4" },
                    { "SE0225", "R003", "G5" },
                    { "SE0226", "R003", "G6" },
                    { "SE0227", "R003", "G7" },
                    { "SE0228", "R003", "G8" },
                    { "SE0229", "R003", "G9" },
                    { "SE0230", "R003", "G10" },
                    { "SE0231", "R003", "H1" },
                    { "SE0232", "R003", "H2" },
                    { "SE0233", "R003", "H3" },
                    { "SE0234", "R003", "H4" },
                    { "SE0235", "R003", "H5" },
                    { "SE0236", "R003", "H6" },
                    { "SE0237", "R003", "H7" },
                    { "SE0238", "R003", "H8" },
                    { "SE0239", "R003", "H9" },
                    { "SE0240", "R003", "H10" },
                    { "SE0241", "R004", "A1" },
                    { "SE0242", "R004", "A2" },
                    { "SE0243", "R004", "A3" },
                    { "SE0244", "R004", "A4" },
                    { "SE0245", "R004", "A5" },
                    { "SE0246", "R004", "A6" },
                    { "SE0247", "R004", "A7" },
                    { "SE0248", "R004", "A8" },
                    { "SE0249", "R004", "A9" },
                    { "SE0250", "R004", "A10" },
                    { "SE0251", "R004", "B1" },
                    { "SE0252", "R004", "B2" },
                    { "SE0253", "R004", "B3" },
                    { "SE0254", "R004", "B4" },
                    { "SE0255", "R004", "B5" },
                    { "SE0256", "R004", "B6" },
                    { "SE0257", "R004", "B7" },
                    { "SE0258", "R004", "B8" },
                    { "SE0259", "R004", "B9" },
                    { "SE0260", "R004", "B10" },
                    { "SE0261", "R004", "C1" },
                    { "SE0262", "R004", "C2" },
                    { "SE0263", "R004", "C3" },
                    { "SE0264", "R004", "C4" },
                    { "SE0265", "R004", "C5" },
                    { "SE0266", "R004", "C6" },
                    { "SE0267", "R004", "C7" },
                    { "SE0268", "R004", "C8" },
                    { "SE0269", "R004", "C9" },
                    { "SE0270", "R004", "C10" },
                    { "SE0271", "R004", "D1" },
                    { "SE0272", "R004", "D2" },
                    { "SE0273", "R004", "D3" },
                    { "SE0274", "R004", "D4" },
                    { "SE0275", "R004", "D5" },
                    { "SE0276", "R004", "D6" },
                    { "SE0277", "R004", "D7" },
                    { "SE0278", "R004", "D8" },
                    { "SE0279", "R004", "D9" },
                    { "SE0280", "R004", "D10" },
                    { "SE0281", "R004", "E1" },
                    { "SE0282", "R004", "E2" },
                    { "SE0283", "R004", "E3" },
                    { "SE0284", "R004", "E4" },
                    { "SE0285", "R004", "E5" },
                    { "SE0286", "R004", "E6" },
                    { "SE0287", "R004", "E7" },
                    { "SE0288", "R004", "E8" },
                    { "SE0289", "R004", "E9" },
                    { "SE0290", "R004", "E10" },
                    { "SE0291", "R004", "F1" },
                    { "SE0292", "R004", "F2" },
                    { "SE0293", "R004", "F3" },
                    { "SE0294", "R004", "F4" },
                    { "SE0295", "R004", "F5" },
                    { "SE0296", "R004", "F6" },
                    { "SE0297", "R004", "F7" },
                    { "SE0298", "R004", "F8" },
                    { "SE0299", "R004", "F9" },
                    { "SE0300", "R004", "F10" },
                    { "SE0301", "R004", "G1" },
                    { "SE0302", "R004", "G2" },
                    { "SE0303", "R004", "G3" },
                    { "SE0304", "R004", "G4" },
                    { "SE0305", "R004", "G5" },
                    { "SE0306", "R004", "G6" },
                    { "SE0307", "R004", "G7" },
                    { "SE0308", "R004", "G8" },
                    { "SE0309", "R004", "G9" },
                    { "SE0310", "R004", "G10" },
                    { "SE0311", "R004", "H1" },
                    { "SE0312", "R004", "H2" },
                    { "SE0313", "R004", "H3" },
                    { "SE0314", "R004", "H4" },
                    { "SE0315", "R004", "H5" },
                    { "SE0316", "R004", "H6" },
                    { "SE0317", "R004", "H7" },
                    { "SE0318", "R004", "H8" },
                    { "SE0319", "R004", "H9" },
                    { "SE0320", "R004", "H10" },
                    { "SE0321", "R005", "A1" },
                    { "SE0322", "R005", "A2" },
                    { "SE0323", "R005", "A3" },
                    { "SE0324", "R005", "A4" },
                    { "SE0325", "R005", "A5" },
                    { "SE0326", "R005", "A6" },
                    { "SE0327", "R005", "A7" },
                    { "SE0328", "R005", "A8" },
                    { "SE0329", "R005", "A9" },
                    { "SE0330", "R005", "A10" },
                    { "SE0331", "R005", "B1" },
                    { "SE0332", "R005", "B2" },
                    { "SE0333", "R005", "B3" },
                    { "SE0334", "R005", "B4" },
                    { "SE0335", "R005", "B5" },
                    { "SE0336", "R005", "B6" },
                    { "SE0337", "R005", "B7" },
                    { "SE0338", "R005", "B8" },
                    { "SE0339", "R005", "B9" },
                    { "SE0340", "R005", "B10" },
                    { "SE0341", "R005", "C1" },
                    { "SE0342", "R005", "C2" },
                    { "SE0343", "R005", "C3" },
                    { "SE0344", "R005", "C4" },
                    { "SE0345", "R005", "C5" },
                    { "SE0346", "R005", "C6" },
                    { "SE0347", "R005", "C7" },
                    { "SE0348", "R005", "C8" },
                    { "SE0349", "R005", "C9" },
                    { "SE0350", "R005", "C10" },
                    { "SE0351", "R005", "D1" },
                    { "SE0352", "R005", "D2" },
                    { "SE0353", "R005", "D3" },
                    { "SE0354", "R005", "D4" },
                    { "SE0355", "R005", "D5" },
                    { "SE0356", "R005", "D6" },
                    { "SE0357", "R005", "D7" },
                    { "SE0358", "R005", "D8" },
                    { "SE0359", "R005", "D9" },
                    { "SE0360", "R005", "D10" },
                    { "SE0361", "R005", "E1" },
                    { "SE0362", "R005", "E2" },
                    { "SE0363", "R005", "E3" },
                    { "SE0364", "R005", "E4" },
                    { "SE0365", "R005", "E5" },
                    { "SE0366", "R005", "E6" },
                    { "SE0367", "R005", "E7" },
                    { "SE0368", "R005", "E8" },
                    { "SE0369", "R005", "E9" },
                    { "SE0370", "R005", "E10" },
                    { "SE0371", "R005", "F1" },
                    { "SE0372", "R005", "F2" },
                    { "SE0373", "R005", "F3" },
                    { "SE0374", "R005", "F4" },
                    { "SE0375", "R005", "F5" },
                    { "SE0376", "R005", "F6" },
                    { "SE0377", "R005", "F7" },
                    { "SE0378", "R005", "F8" },
                    { "SE0379", "R005", "F9" },
                    { "SE0380", "R005", "F10" },
                    { "SE0381", "R005", "G1" },
                    { "SE0382", "R005", "G2" },
                    { "SE0383", "R005", "G3" },
                    { "SE0384", "R005", "G4" },
                    { "SE0385", "R005", "G5" },
                    { "SE0386", "R005", "G6" },
                    { "SE0387", "R005", "G7" },
                    { "SE0388", "R005", "G8" },
                    { "SE0389", "R005", "G9" },
                    { "SE0390", "R005", "G10" },
                    { "SE0391", "R005", "H1" },
                    { "SE0392", "R005", "H2" },
                    { "SE0393", "R005", "H3" },
                    { "SE0394", "R005", "H4" },
                    { "SE0395", "R005", "H5" },
                    { "SE0396", "R005", "H6" },
                    { "SE0397", "R005", "H7" },
                    { "SE0398", "R005", "H8" },
                    { "SE0399", "R005", "H9" },
                    { "SE0400", "R005", "H10" }
                });

            migrationBuilder.InsertData(
                table: "Showtimes",
                columns: new[] { "ShowtimeId", "CreatedAt", "EndTime", "MovieId", "RoomId", "StartTime", "Status", "UpdatedAt" },
                values: new object[,]
                {
                    { "ST001", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 10, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST002", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 14, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 10, 12, 30, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST003", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 17, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 10, 15, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST004", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 19, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 10, 17, 30, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST005", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 13, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R002", new DateTime(2026, 6, 10, 11, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST006", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 15, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R002", new DateTime(2026, 6, 10, 13, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST007", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 10, 14, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R003", new DateTime(2026, 6, 10, 12, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST008", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 23, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST009", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 14, 30, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 23, 12, 30, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST010", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 13, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R002", new DateTime(2026, 6, 23, 11, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST011", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 23, 14, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R003", new DateTime(2026, 6, 23, 12, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST012", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 24, 12, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R001", new DateTime(2026, 6, 24, 10, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST013", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 24, 13, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R002", new DateTime(2026, 6, 24, 11, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { "ST014", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2026, 6, 24, 14, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "R003", new DateTime(2026, 6, 24, 12, 0, 0, 0, DateTimeKind.Unspecified), "AVAILABLE", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "WatchLists",
                columns: new[] { "WatchListId", "CreatedAt", "MovieId", "UserId", "type" },
                values: new object[,]
                {
                    { "WL001", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV001", "USR001", "FAVORITE" },
                    { "WL002", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV003", "USR001", "FAVORITE" },
                    { "WL003", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV002", "USR002", "WATCH_LATER" },
                    { "WL004", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV005", "USR002", "WATCH_LATER" },
                    { "WL005", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV004", "USR003", "FAVORITE" },
                    { "WL006", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV007", "USR003", "WATCH_LATER" },
                    { "WL007", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV006", "USR004", "FAVORITE" },
                    { "WL008", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV008", "USR004", "WATCH_LATER" },
                    { "WL009", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV009", "USR005", "FAVORITE" },
                    { "WL010", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MOV010", "USR005", "WATCH_LATER" }
                });

            migrationBuilder.InsertData(
                table: "Bookings",
                columns: new[] { "BookingId", "CreatedAt", "OrderCode", "ShowtimeId", "Status", "TotalAmount", "UserId" },
                values: new object[,]
                {
                    { "BK400", new DateTime(2026, 3, 25, 18, 59, 3, 0, DateTimeKind.Unspecified), 0L, "ST001", "CONFIRMED", 200000.0, "USR002" },
                    { "BK401", new DateTime(2026, 3, 25, 18, 59, 3, 0, DateTimeKind.Unspecified), 0L, "ST002", "CONFIRMED", 300000.0, "USR002" },
                    { "BK402", new DateTime(2026, 3, 25, 18, 59, 3, 0, DateTimeKind.Unspecified), 0L, "ST003", "CONFIRMED", 150000.0, "USR002" },
                    { "BK403", new DateTime(2026, 3, 25, 18, 59, 3, 0, DateTimeKind.Unspecified), 0L, "ST004", "CONFIRMED", 400000.0, "USR002" },
                    { "BK404", new DateTime(2026, 3, 25, 18, 59, 3, 0, DateTimeKind.Unspecified), 0L, "ST005", "CONFIRMED", 250000.0, "USR002" }
                });

            migrationBuilder.InsertData(
                table: "Comments",
                columns: new[] { "CommentId", "BlogPostId", "Content", "CreatedDate", "UserId" },
                values: new object[,]
                {
                    { "CMT001", "BLOG001", "Great list! I love Marvel movies.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" },
                    { "CMT002", "BLOG001", "Avengers Endgame is my favorite.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "CMT003", "BLOG001", "Nice recommendations!", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR004" },
                    { "CMT004", "BLOG002", "Horror movies are so thrilling!", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "CMT005", "BLOG002", "The Conjuring series is amazing.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR005" },
                    { "CMT006", "BLOG002", "I love watching horror at night.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "CMT007", "BLOG003", "Interstellar is a masterpiece.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "CMT008", "BLOG003", "Sci-Fi movies inspire imagination.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" },
                    { "CMT009", "BLOG003", "I love futuristic technology.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR005" },
                    { "CMT010", "BLOG004", "Perfect movies for couples.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "CMT011", "BLOG004", "Titanic will always be iconic.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" },
                    { "CMT012", "BLOG004", "Romantic movies are emotional.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "CMT013", "BLOG005", "Can't wait for next year's movies!", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR004" },
                    { "CMT014", "BLOG005", "So many exciting releases.", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "CMT015", "BLOG005", "Hope Marvel releases new films!", new DateTime(2026, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" }
                });

            migrationBuilder.InsertData(
                table: "PostLikes",
                columns: new[] { "PostLikeId", "BlogPostId", "CreatedAt", "UserId" },
                values: new object[,]
                {
                    { "LIKE001", "BLOG001", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "LIKE002", "BLOG001", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" },
                    { "LIKE003", "BLOG002", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "LIKE004", "BLOG003", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "LIKE005", "BLOG004", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR005" },
                    { "LIKE006", "BLOG002", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR001" },
                    { "LIKE007", "BLOG003", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR002" },
                    { "LIKE008", "BLOG004", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR003" },
                    { "LIKE009", "BLOG005", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR004" },
                    { "LIKE010", "BLOG001", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "USR005" }
                });

            migrationBuilder.InsertData(
                table: "ShowtimeTicketTypes",
                columns: new[] { "ShowtimeTicketTypeId", "Price", "ShowtimeId", "TicketTypeId" },
                values: new object[,]
                {
                    { "STT001", 120000.0, "ST001", "TT001" },
                    { "STT002", 120000.0, "ST002", "TT001" },
                    { "STT003", 120000.0, "ST003", "TT001" },
                    { "STT004", 120000.0, "ST004", "TT001" },
                    { "STT005", 170000.0, "ST005", "TT002" },
                    { "STT006", 170000.0, "ST006", "TT002" },
                    { "STT007", 220000.0, "ST007", "TT003" },
                    { "STT008", 120000.0, "ST008", "TT001" },
                    { "STT009", 120000.0, "ST009", "TT001" },
                    { "STT010", 170000.0, "ST010", "TT002" },
                    { "STT011", 220000.0, "ST011", "TT003" },
                    { "STT012", 120000.0, "ST012", "TT001" },
                    { "STT013", 170000.0, "ST013", "TT002" },
                    { "STT014", 220000.0, "ST014", "TT003" }
                });

            migrationBuilder.InsertData(
                table: "BookingSeats",
                columns: new[] { "BookingSeatId", "BookingId", "CheckinTime", "Price", "QrCode", "SeatId", "ShowtimeTicketTypeId", "Status" },
                values: new object[,]
                {
                    { "BS400", "BK400", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 100000.0, "QR400", "SE0001", "STT001", "BOOKED" },
                    { "BS401", "BK400", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 100000.0, "QR401", "SE0002", "STT001", "BOOKED" },
                    { "BS402", "BK401", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 150000.0, "QR402", "SE0003", "STT001", "BOOKED" },
                    { "BS403", "BK401", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 150000.0, "QR403", "SE0004", "STT001", "BOOKED" },
                    { "BS404", "BK402", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 75000.0, "QR404", "SE0005", "STT001", "BOOKED" },
                    { "BS405", "BK402", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 75000.0, "QR405", "SE0006", "STT001", "BOOKED" },
                    { "BS406", "BK403", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 200000.0, "QR406", "SE0007", "STT001", "BOOKED" },
                    { "BS407", "BK403", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 200000.0, "QR407", "SE0008", "STT001", "BOOKED" },
                    { "BS408", "BK404", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 125000.0, "QR408", "SE0009", "STT001", "BOOKED" },
                    { "BS409", "BK404", new DateTime(2026, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 125000.0, "QR409", "SE0010", "STT001", "BOOKED" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_BlogPosts_UserId",
                table: "BlogPosts",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_BookingFoodCombos_BookingId",
                table: "BookingFoodCombos",
                column: "BookingId");

            migrationBuilder.CreateIndex(
                name: "IX_BookingFoodCombos_FoodComboId",
                table: "BookingFoodCombos",
                column: "FoodComboId");

            migrationBuilder.CreateIndex(
                name: "IX_Bookings_ShowtimeId",
                table: "Bookings",
                column: "ShowtimeId");

            migrationBuilder.CreateIndex(
                name: "IX_Bookings_UserId",
                table: "Bookings",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeats_BookingId",
                table: "BookingSeats",
                column: "BookingId");

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeats_SeatId_ShowtimeTicketTypeId",
                table: "BookingSeats",
                columns: new[] { "SeatId", "ShowtimeTicketTypeId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_BookingSeats_ShowtimeTicketTypeId",
                table: "BookingSeats",
                column: "ShowtimeTicketTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_BookingVouchers_VoucherId",
                table: "BookingVouchers",
                column: "VoucherId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_BlogPostId",
                table: "Comments",
                column: "BlogPostId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserId",
                table: "Comments",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_MovieCasts_CastId",
                table: "MovieCasts",
                column: "CastId");

            migrationBuilder.CreateIndex(
                name: "IX_MovieGenres_GenreId",
                table: "MovieGenres",
                column: "GenreId");

            migrationBuilder.CreateIndex(
                name: "IX_MovieRatings_MovieId",
                table: "MovieRatings",
                column: "MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_MovieRatings_UserId",
                table: "MovieRatings",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_BlogPostId",
                table: "Notifications",
                column: "BlogPostId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_BookingSeatId",
                table: "Notifications",
                column: "BookingSeatId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_CommentId",
                table: "Notifications",
                column: "CommentId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_UserId",
                table: "Notifications",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_WatchListId",
                table: "Notifications",
                column: "WatchListId");

            migrationBuilder.CreateIndex(
                name: "IX_Payments_BookingId",
                table: "Payments",
                column: "BookingId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Payments_PaymentMethodId",
                table: "Payments",
                column: "PaymentMethodId");

            migrationBuilder.CreateIndex(
                name: "IX_Posters_MovieId",
                table: "Posters",
                column: "MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_PostLikes_BlogPostId",
                table: "PostLikes",
                column: "BlogPostId");

            migrationBuilder.CreateIndex(
                name: "IX_PostLikes_UserId",
                table: "PostLikes",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Rooms_CinemaId",
                table: "Rooms",
                column: "CinemaId");

            migrationBuilder.CreateIndex(
                name: "IX_SeatLocks_SeatId",
                table: "SeatLocks",
                column: "SeatId");

            migrationBuilder.CreateIndex(
                name: "IX_SeatLocks_ShowtimeId",
                table: "SeatLocks",
                column: "ShowtimeId");

            migrationBuilder.CreateIndex(
                name: "IX_SeatLocks_UserId",
                table: "SeatLocks",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Seats_RoomId",
                table: "Seats",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_Showtimes_MovieId",
                table: "Showtimes",
                column: "MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_Showtimes_RoomId",
                table: "Showtimes",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_ShowtimeTicketTypes_ShowtimeId",
                table: "ShowtimeTicketTypes",
                column: "ShowtimeId");

            migrationBuilder.CreateIndex(
                name: "IX_ShowtimeTicketTypes_TicketTypeId",
                table: "ShowtimeTicketTypes",
                column: "TicketTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_UserGenres_GenreId",
                table: "UserGenres",
                column: "GenreId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_RoleId",
                table: "Users",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_UserVouchers_VoucherId",
                table: "UserVouchers",
                column: "VoucherId");

            migrationBuilder.CreateIndex(
                name: "IX_WatchLists_MovieId",
                table: "WatchLists",
                column: "MovieId");

            migrationBuilder.CreateIndex(
                name: "IX_WatchLists_UserId",
                table: "WatchLists",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BookingFoodCombos");

            migrationBuilder.DropTable(
                name: "BookingVouchers");

            migrationBuilder.DropTable(
                name: "MovieCasts");

            migrationBuilder.DropTable(
                name: "MovieGenres");

            migrationBuilder.DropTable(
                name: "MovieRatings");

            migrationBuilder.DropTable(
                name: "Notifications");

            migrationBuilder.DropTable(
                name: "Payments");

            migrationBuilder.DropTable(
                name: "Posters");

            migrationBuilder.DropTable(
                name: "PostLikes");

            migrationBuilder.DropTable(
                name: "SeatLocks");

            migrationBuilder.DropTable(
                name: "UserGenres");

            migrationBuilder.DropTable(
                name: "UserVouchers");

            migrationBuilder.DropTable(
                name: "FoodCombos");

            migrationBuilder.DropTable(
                name: "Casts");

            migrationBuilder.DropTable(
                name: "BookingSeats");

            migrationBuilder.DropTable(
                name: "Comments");

            migrationBuilder.DropTable(
                name: "WatchLists");

            migrationBuilder.DropTable(
                name: "PaymentMethods");

            migrationBuilder.DropTable(
                name: "Genres");

            migrationBuilder.DropTable(
                name: "Vouchers");

            migrationBuilder.DropTable(
                name: "Bookings");

            migrationBuilder.DropTable(
                name: "Seats");

            migrationBuilder.DropTable(
                name: "ShowtimeTicketTypes");

            migrationBuilder.DropTable(
                name: "BlogPosts");

            migrationBuilder.DropTable(
                name: "Showtimes");

            migrationBuilder.DropTable(
                name: "TicketTypes");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Movies");

            migrationBuilder.DropTable(
                name: "Rooms");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Cinemas");
        }
    }
}
