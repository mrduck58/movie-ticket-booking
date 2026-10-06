using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.BlogPost;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Foods;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Notificaions;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Payments;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Profile;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Search;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Ticket;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Implementations.Cinemas;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Foods;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Notifications;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Payments;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Profile;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Search;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Ticket;
using Movie_Ticket_Booking_Backend.Services.Implementations.BlogPost;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Vouchers;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Vouchers;
using Movie_Ticket_Booking_Backend.Services.Implementations.Foods;
using Movie_Ticket_Booking_Backend.Services.Implementations.Movie;
using Movie_Ticket_Booking_Backend.Services.Implementations.Movies;
using Movie_Ticket_Booking_Backend.Services.Implementations.Notifications;
using Movie_Ticket_Booking_Backend.Services.Implementations.Payments;
using Movie_Ticket_Booking_Backend.Services.Implementations.Profile;
using Movie_Ticket_Booking_Backend.Services.Implementations.Search;
using Movie_Ticket_Booking_Backend.Services.Implementations.Ticket;
using Movie_Ticket_Booking_Backend.Services.Implementations.User;
using Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost;
using Movie_Ticket_Booking_Backend.Services.Implementations.Vouchers;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Foods;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Movies;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Notifications;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Profile;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Search;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Ticket;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Vouchers;
using System.Text;

namespace Movie_Ticket_Booking_Backend
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // DB
            builder.Services.AddDbContext<AppDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

            // Services
            builder.Services.AddScoped<AuthService>();
            builder.Services.AddScoped<JwtService>();
            builder.Services.AddScoped<UserService>();

            builder.Services.AddControllers();
            builder.Services.AddOpenApi();

            // CORS
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", policy =>
                {
                    policy.SetIsOriginAllowed(origin => new Uri(origin).Host == "localhost") // Chấp nhận mọi Port từ localhost
                          .AllowAnyMethod()
                          .AllowAnyHeader()
                          .AllowCredentials(); // Quan trọng nếu sau này bạn dùng Cookie/Session
                });
            });

            // JWT
            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,

                    ValidIssuer = builder.Configuration["Jwt:Issuer"],
                    ValidAudience = builder.Configuration["Jwt:Audience"],

                    IssuerSigningKey = new SymmetricSecurityKey(
                        Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"])
                    )
                };
            });
            //blogpost
            builder.Services.AddScoped<IBlogRepository, BlogRepository>();
            builder.Services.AddScoped<IBlogService, BlogService>();
            //comment
            builder.Services.AddScoped<ICommentRepository, CommentRepository>();
            builder.Services.AddScoped<ICommentService, CommentService>();
            builder.Services.AddScoped<ITicketRepository, TicketRepository>();
            // Ticket
            builder.Services.AddScoped<ITicketRepository, TicketRepository>();
            builder.Services.AddScoped<ITicketService, TicketService>();
            // Profile
            builder.Services.AddScoped<IProfileRepository, ProfileRepository>();
            builder.Services.AddScoped<IProfileService, ProfileService>();
            ///watchlist
            builder.Services.AddScoped<IWatchListRepository, WatchListRepository>();
            builder.Services.AddScoped<IWatchListService, WatchListService>();

            ///search
            builder.Services.AddScoped<ISearchRepository, SearchRepository>();
            builder.Services.AddScoped<ISearchService, SearchService>();

            //notifications
            builder.Services.AddScoped<INotificationRepository, NotificationRepository>();
            builder.Services.AddScoped<INotificationService, NotificationService>();

            ///payment_method
            builder.Services.AddScoped<IPaymentMethodRepository, PaymentMethodRepository>();
            builder.Services.AddScoped<IPaymentMethodService, PaymentMethodService>();

            builder.Services.AddScoped<IMovieRepository, MovieRepository>();
            builder.Services.AddScoped<IMovieService, MovieService>();

            builder.Services.AddScoped<ICinemaRepository, CinemaRepository>();
            builder.Services.AddScoped<ICinemaService, CinemaService>();

            builder.Services.AddScoped<IGenreRepository, GenreRepository>();
            builder.Services.AddScoped<IGenreService, GenreService>();

            builder.Services.AddScoped<IRoomRepository, RoomRepository>();
            builder.Services.AddScoped<IRoomService, RoomService>();

            builder.Services.AddScoped<IShowtimeRepository, ShowtimeRepository>();
            builder.Services.AddScoped<IShowtimeService, ShowtimeService>();

            builder.Services.AddScoped<ISeatRepository, SeatRepository>();
            builder.Services.AddScoped<ISeatLockRepository, SeatLockRepository>();
            builder.Services.AddScoped<ISeatService, SeatService>();

            // Favorite Cinema
            builder.Services.AddScoped<IFavoriteCinemaRepository, FavoriteCinemaRepository>();
            builder.Services.AddScoped<IFavoriteCinemaService, FavoriteCinemaService>();

            builder.Services.AddScoped<IComboRepository, ComboRepository>();
            builder.Services.AddScoped<IComboService, ComboService>();

            builder.Services.AddScoped<IVoucherRepository, VoucherRepository>();
            builder.Services.AddScoped<IVoucherService, VoucherService>();

            builder.Services.AddScoped<IBookingRepository, BookingRepository>();
            builder.Services.AddScoped<IBookingService, BookingService>();
            builder.Services.AddScoped<Movie_Ticket_Booking_Backend.Services.Interfaces.Payments.IPayOSService,
                Movie_Ticket_Booking_Backend.Services.Implementations.Payments.PayOSService>();

            builder.Services.AddScoped<IPosterRepository, PosterRepository>();
            builder.Services.AddScoped<IPosterService, PosterService>();

            builder.Services.AddScoped<IMovieCastRepository, MovieCastRepository>();
            builder.Services.AddScoped<IMovieGenreRepository, MovieGenreRepository>();

            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    p => p.AllowAnyOrigin()
                          .AllowAnyMethod()
                          .AllowAnyHeader());
            });

            builder.Services.AddMemoryCache(); // Để lưu mã OTP tạm thời
            builder.Services.AddScoped<IEmailService, EmailService>();

            // Register Background Jobs
            builder.Services.AddHostedService<Movie_Ticket_Booking_Backend.Services.Implementations.BackgroundJobs.SeatLockCleanupService>();

            var app = builder.Build();

            // Auto apply EF Core Migrations (với retry cho Docker)
            using (var scope = app.Services.CreateScope())
            {
                var services = scope.ServiceProvider;
                try
                {
                    var context = services.GetRequiredService<AppDbContext>();
                    int retries = 5;
                    while (retries > 0)
                    {
                        try
                        {
                            context.Database.Migrate();
                            Console.WriteLine("Database migrations applied successfully.");
                            break;
                        }
                        catch (Exception ex)
                        {
                            retries--;
                            Console.WriteLine($"Waiting for DB connection... retries left: {retries}. Error: {ex.Message}");
                            if (retries == 0) break;
                            Thread.Sleep(5000);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error applying migrations: {ex.Message}");
                }
            }

            if (app.Environment.IsDevelopment())
            {
                app.MapOpenApi();
            }

            if (!app.Environment.IsDevelopment())
            {
                app.UseHttpsRedirection();
            }

            // Enable CORS
            app.UseCors("AllowAll");

            // JWT middleware
            app.UseAuthentication();
            app.UseAuthorization();

            app.MapControllers();

            app.Run();

           
        }
    }
}