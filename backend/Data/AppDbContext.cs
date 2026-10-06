using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Foods;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Domain.Payments;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;
using Movie_Ticket_Booking_Backend.Domain.Users;
using Movie_Ticket_Booking_Backend.Domain.Vouchers;

namespace Movie_Ticket_Booking_Backend.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        //User and Role tables for authentication and authorization
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }

        //Movie related tables
        public DbSet<Movie> Movies { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Cast> Casts { get; set; }
        public DbSet<Poster> Posters { get; set; }
        public DbSet<MovieGenre> MovieGenres { get; set; }
        public DbSet<MovieCast> MovieCasts { get; set; }
        public DbSet<MovieRating> MovieRatings { get; set; }
        public DbSet<WatchList> WatchLists { get; set; }

        //Cinema related tables
        public DbSet<Cinema> Cinemas { get; set; }
        public DbSet<Room> Rooms { get; set; }
        public DbSet<Seat> Seats { get; set; }
        public DbSet<SeatLock> SeatLocks { get; set; }
        public DbSet<FavoriteCinema> FavoriteCinemas { get; set; }

        //Showtime and ticket related tables
        public DbSet<Showtime> Showtimes { get; set; }
        public DbSet<TicketType> TicketTypes { get; set; }
        public DbSet<ShowtimeTicketType> ShowtimeTicketTypes { get; set; }

        //Booking related tables
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<BookingSeat> BookingSeats { get; set; }
        public DbSet<BookingVoucher> BookingVouchers { get; set; }
        public DbSet<BookingFoodCombo> BookingFoodCombos { get; set; }

        //Payment related tables
        public DbSet<Payment> Payments { get; set; }
        public DbSet<PaymentMethod> PaymentMethods { get; set; }

        //Food and combo related tables
        public DbSet<FoodCombo> FoodCombos { get; set; }

        //Voucher related tables
        public DbSet<Voucher> Vouchers { get; set; }
        public DbSet<UserVoucher> UserVouchers { get; set; }

        //Blog related tables
        public DbSet<BlogPost> BlogPosts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<PostLike> PostLikes { get; set; }
        public DbSet<UserGenre> UserGenres { get; set; }
        public DbSet<Notification> Notifications { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            foreach (var relationship in modelBuilder.Model
                .GetEntityTypes()
                .SelectMany(e => e.GetForeignKeys()))
            {
                relationship.DeleteBehavior = DeleteBehavior.Restrict;
            }

            // ========================
            // USER - ROLE
            // ========================
            modelBuilder.Entity<User>()
                .HasOne(u => u.Role)
                .WithMany(r => r.Users)
                .HasForeignKey(u => u.RoleId);

            // ========================
            // MOVIE - GENRE (MANY TO MANY)
            // ========================
            modelBuilder.Entity<MovieGenre>()
                .HasKey(mg => new { mg.MovieId, mg.GenreId });

            modelBuilder.Entity<MovieGenre>()
                .HasOne(mg => mg.Movie)
                .WithMany(m => m.MovieGenres)
                .HasForeignKey(mg => mg.MovieId);

            modelBuilder.Entity<MovieGenre>()
                .HasOne(mg => mg.Genre)
                .WithMany(g => g.MovieGenres)
                .HasForeignKey(mg => mg.GenreId);

            // ========================
            // MOVIE - CAST (MANY TO MANY)
            // ========================
            modelBuilder.Entity<MovieCast>()
                .HasKey(mc => new { mc.MovieId, mc.CastId });

            modelBuilder.Entity<MovieCast>()
                .HasOne(mc => mc.Movie)
                .WithMany(m => m.MovieCasts)
                .HasForeignKey(mc => mc.MovieId);

            modelBuilder.Entity<MovieCast>()
                .HasOne(mc => mc.Cast)
                .WithMany(c => c.MovieCasts)
                .HasForeignKey(mc => mc.CastId);

            // ========================
            // MOVIE - POSTER
            // ========================
            modelBuilder.Entity<Poster>()
                .HasOne(p => p.Movie)
                .WithMany(m => m.Posters)
                .HasForeignKey(p => p.MovieId);

            // ========================
            // CINEMA - ROOM
            // ========================
            modelBuilder.Entity<Room>()
                .HasOne(r => r.Cinema)
                .WithMany(c => c.Rooms)
                .HasForeignKey(r => r.CinemaId);

            // ========================
            // ROOM - SEAT
            // ========================
            modelBuilder.Entity<Seat>()
                .HasOne(s => s.Room)
                .WithMany(r => r.Seats)
                .HasForeignKey(s => s.RoomId);

            // ========================
            // SEAT LOCK
            // ========================
            modelBuilder.Entity<SeatLock>()
                .HasOne(sl => sl.Seat)
                .WithMany(s => s.SeatLocks)
                .HasForeignKey(sl => sl.SeatId);

            modelBuilder.Entity<SeatLock>()
                .HasOne(sl => sl.User)
                .WithMany(u => u.SeatLocks)
                .HasForeignKey(sl => sl.UserId);

            modelBuilder.Entity<SeatLock>()
                .HasOne(sl => sl.Showtime)
                .WithMany(st => st.SeatLocks)
                .HasForeignKey(sl => sl.ShowtimeId);

            // ========================
            // FAVORITE CINEMA
            // ========================
            modelBuilder.Entity<FavoriteCinema>()
                .HasOne(fc => fc.User)
                .WithMany(u => u.FavoriteCinemas)
                .HasForeignKey(fc => fc.UserId);

            modelBuilder.Entity<FavoriteCinema>()
                .HasOne(fc => fc.Cinema)
                .WithMany(c => c.FavoriteCinemas)
                .HasForeignKey(fc => fc.CinemaId);

            // ========================
            // SHOWTIME
            // ========================
            modelBuilder.Entity<Showtime>()
                .HasOne(st => st.Movie)
                .WithMany(m => m.Showtimes)
                .HasForeignKey(st => st.MovieId);

            modelBuilder.Entity<Showtime>()
                .HasOne(st => st.Room)
                .WithMany(r => r.Showtimes)
                .HasForeignKey(st => st.RoomId);

            // ========================
            // SHOWTIME - TICKET TYPE
            // ========================
            modelBuilder.Entity<ShowtimeTicketType>()
                .HasOne(stt => stt.Showtime)
                .WithMany(st => st.ShowtimeTicketTypes)
                .HasForeignKey(stt => stt.ShowtimeId);

            modelBuilder.Entity<ShowtimeTicketType>()
                .HasOne(stt => stt.TicketType)
                .WithMany(tt => tt.ShowtimeTicketTypes)
                .HasForeignKey(stt => stt.TicketTypeId);

            // ========================
            // BOOKING
            // ========================
            modelBuilder.Entity<Booking>()
                .HasOne(b => b.User)
                .WithMany(u => u.Bookings)
                .HasForeignKey(b => b.UserId);

            modelBuilder.Entity<Booking>()
                .HasOne(b => b.Showtime)
                .WithMany(st => st.Bookings)
                .HasForeignKey(b => b.ShowtimeId);
            // ========================
            // Moovie Rating
            modelBuilder.Entity<MovieRating>()
     .HasOne(r => r.Movie)
     .WithMany(m => m.MovieRatings)   // 🔥 FIX
     .HasForeignKey(r => r.MovieId);

            modelBuilder.Entity<MovieRating>()
                .HasOne(r => r.User)
                .WithMany(u => u.MovieRatings)   // 🔥 FIX
                .HasForeignKey(r => r.UserId);
            // ========================
            // BOOKING SEAT
            // ========================
            modelBuilder.Entity<BookingSeat>()
                .HasOne(bs => bs.Booking)
                .WithMany(b => b.BookingSeats)
                .HasForeignKey(bs => bs.BookingId);

            modelBuilder.Entity<BookingSeat>()
                .HasOne(bs => bs.Seat)
                .WithMany(s => s.BookingSeats)
                .HasForeignKey(bs => bs.SeatId);

            modelBuilder.Entity<BookingSeat>()
                .HasOne(bs => bs.ShowtimeTicketType)
                .WithMany(stt => stt.BookingSeats)
                .HasForeignKey(bs => bs.ShowtimeTicketTypeId);

            // ========================
            // BOOKING FOOD COMBO
            // ========================
            modelBuilder.Entity<BookingFoodCombo>()
                .HasKey(bfc => bfc.BookingFoodComboId);

            modelBuilder.Entity<BookingFoodCombo>()
                .HasOne(bfc => bfc.Booking)
                .WithMany(b => b.BookingFoodCombos)
                .HasForeignKey(bfc => bfc.BookingId);

            modelBuilder.Entity<BookingFoodCombo>()
                .HasOne(bfc => bfc.FoodCombo)
                .WithMany(fc => fc.BookingFoodCombos)
                .HasForeignKey(bfc => bfc.FoodComboId);

            // ========================
            // BOOKING VOUCHER
            // ========================
            modelBuilder.Entity<BookingVoucher>()
                .HasKey(bv => new { bv.BookingId, bv.VoucherId });

            modelBuilder.Entity<BookingVoucher>()
                .HasOne(bv => bv.Booking)
                .WithMany(b => b.BookingVouchers)
                .HasForeignKey(bv => bv.BookingId);

            modelBuilder.Entity<BookingVoucher>()
                .HasOne(bv => bv.Voucher)
                .WithMany(v => v.BookingVouchers)
                .HasForeignKey(bv => bv.VoucherId);

            // ========================
            // PAYMENT (1-1 BOOKING)
            // ========================
            modelBuilder.Entity<Payment>()
                .HasOne(p => p.Booking)
                .WithOne(b => b.Payment)
                .HasForeignKey<Payment>(p => p.BookingId);

            modelBuilder.Entity<Payment>()
                .HasOne(p => p.PaymentMethod)
                .WithMany(pm => pm.Payments)
                .HasForeignKey(p => p.PaymentMethodId);

            // ========================
            // BLOG
            // ========================
            modelBuilder.Entity<BlogPost>()
                .HasOne(bp => bp.User)
                .WithMany(u => u.BlogPosts)
                .HasForeignKey(bp => bp.UserId);
            //.OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Comment>()
                .HasOne(c => c.User)
                .WithMany(u => u.Comments)
                .HasForeignKey(c => c.UserId);
            //.OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Comment>()
                .HasOne(c => c.BlogPost)
                .WithMany(bp => bp.Comments)
                .HasForeignKey(c => c.BlogPostId);
            //.OnDelete(DeleteBehavior.Cascade);



            // ========================
            // WatchList
            // ========================
            modelBuilder.Entity<WatchList>()
            .HasOne(w => w.User)
            .WithMany(u => u.WatchLists)
            .HasForeignKey(w => w.UserId);

            modelBuilder.Entity<WatchList>()
            .HasOne(w => w.Movie)
            .WithMany(m => m.WatchLists)
            .HasForeignKey(w => w.MovieId);

            // ========================
            // UserGenre
            // ========================
            modelBuilder.Entity<UserGenre>()
           .HasKey(ug => new { ug.UserId, ug.GenreId });

            modelBuilder.Entity<UserGenre>()
                .HasOne(ug => ug.User)
                .WithMany(u => u.UserGenres)
                .HasForeignKey(ug => ug.UserId);

            modelBuilder.Entity<UserGenre>()
                .HasOne(ug => ug.Genre)
                .WithMany(g => g.UserGenres)
                .HasForeignKey(ug => ug.GenreId);

            // ========================
            // UserVoucher
            // ========================
            modelBuilder.Entity<UserVoucher>()
           .HasKey(ug => new { ug.UserId, ug.VoucherId });

            modelBuilder.Entity<UserVoucher>()
                .HasOne(ug => ug.User)
                .WithMany(u => u.UserVouchers)
                .HasForeignKey(ug => ug.UserId);

            modelBuilder.Entity<UserVoucher>()
                .HasOne(ug => ug.Voucher)
                .WithMany(g => g.UserVouchers)
                .HasForeignKey(ug => ug.VoucherId);

            // ========================
            // Notification
            // ========================
            modelBuilder.Entity<Notification>()
                .HasOne(n => n.User)
                .WithMany(u => u.Notifications)
                .HasForeignKey(n => n.UserId);

            modelBuilder.Entity<Notification>()
                .HasOne(n => n.WatchList)
                .WithMany(w => w.Notifications)
                .HasForeignKey(n => n.WatchListId)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Notification>()
                .HasOne(n => n.BlogPost)
                .WithMany(b => b.Notifications)
                .HasForeignKey(n => n.BlogPostId)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Notification>()
                .HasOne(n => n.Comment)
                .WithMany(c => c.Notifications)
                .HasForeignKey(n => n.CommentId)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Notification>()
                .HasOne(n => n.BookingSeat)
                .WithMany(b => b.Notifications)
                .HasForeignKey(n => n.BookingSeatId)
                .OnDelete(DeleteBehavior.SetNull);

            // ========================
            // Indexes and constraints
            // ========================
            modelBuilder.Entity<BookingSeat>()
                .HasIndex(bs => new { bs.SeatId, bs.ShowtimeTicketTypeId });
            // ========================
            // SEED MOVIES
            // ========================

            modelBuilder.Entity<Movie>().HasData(

                new Movie
                {
                    MovieId = "MOV001",
                    Title = "Avengers: Endgame",
                    TitleVn = "Biệt Đội Siêu Anh Hùng: Hồi Kết",
                    Description = "The Avengers assemble for the final battle against Thanos.",
                    TrailerUrl = "https://www.youtube.com/watch?v=TcMBFSGVi1c",
                    Duration = 181,
                    Director = "Anthony Russo, Joe Russo",
                    Rating = 8.4,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV002",
                    Title = "Spider-Man: No Way Home",
                    TitleVn = "Người Nhện: Không Còn Nhà",
                    Description = "Spider-Man faces villains from different universes.",
                    TrailerUrl = "https://www.youtube.com/watch?v=JfVOs4VSpmA",
                    Duration = 148,
                    Director = "Jon Watts",
                    Rating = 8.2,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV003",
                    Title = "The Batman",
                    TitleVn = "Người Dơi",
                    Description = "Batman investigates corruption in Gotham.",
                    TrailerUrl = "https://www.youtube.com/watch?v=mqqft2x_Aa4",
                    Duration = 176,
                    Director = "d8",
                    Rating = 7.9,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV004",
                    Title = "Doctor Strange in the Multiverse of Madness",
                    TitleVn = "Phù Thủy Tối Thượng: Đa Vũ Trụ Hỗn Loạn",
                    Description = "Doctor Strange explores the multiverse.",
                    TrailerUrl = "https://www.youtube.com/watch?v=aWzlQ2N6qqg",
                    Duration = 126,
                    Director = "d7",
                    Rating = 7.0,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV005",
                    Title = "Deadpool & Wolverine",
                    TitleVn = "Deadpool & Wolverine",
                    Description = "Deadpool meets Wolverine in a chaotic adventure.",
                    TrailerUrl = "https://www.youtube.com/watch?v=73_1biulkYk",
                    Duration = 130,
                    Director = "d6",
                    Rating = 0,
                    Status = "COMINGSOON",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV006",
                    Title = "Joker: Folie à Deux",
                    TitleVn = "Joker: Điên Cuồng Hai Người",
                    Description = "Arthur Fleck continues his descent into madness.",
                    TrailerUrl = "https://www.youtube.com/watch?v=xy8aJw1vYHo",
                    Duration = 138,
                    Director = "d5",
                    Rating = 0,
                    Status = "COMINGSOON",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV007",
                    Title = "Kung Fu Panda 4",
                    TitleVn = "Kung Fu Panda 4",
                    Description = "Po trains a new dragon warrior.",
                    TrailerUrl = "https://www.youtube.com/watch?v=_inKs4eeHiI",
                    Duration = 95,
                    Director = "d4",
                    Rating = 0,
                    Status = "COMINGSOON",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV008",
                    Title = "Mission Impossible 8",
                    TitleVn = "Nhiệm Vụ Bất Khả Thi 8",
                    Description = "Ethan Hunt returns for his most dangerous mission.",
                    TrailerUrl = "https://www.youtube.com/watch?v=avz06PDqDbM",
                    Duration = 160,
                    Director = "d3",
                    Rating = 0,
                    Status = "COMINGSOON",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV009",
                    Title = "Avatar: The Way of Water",
                    TitleVn = "Avatar: Dòng Chảy Của Nước",
                    Description = "Jake Sully protects his family on Pandora.",
                    TrailerUrl = "https://www.youtube.com/watch?v=d9MyW72ELq0",
                    Duration = 192,
                    Director = "d2",
                    Rating = 7.7,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                },

                new Movie
                {
                    MovieId = "MOV010",
                    Title = "Top Gun: Maverick",
                    TitleVn = "Top Gun: Maverick",
                    Description = "Maverick trains a new generation of pilots.",
                    TrailerUrl = "https://www.youtube.com/watch?v=giXco2jaZ_4",
                    Duration = 131,
                    Director = "d1",
                    Rating = 8.3,
                    Status = "NOWSHOWING",
                    CreatedAt = new DateTime(2024, 1, 1),
                    UpdatedAt = new DateTime(2024, 1, 1)
                }

            );

            // ========================
            // SEED CAST
            // ========================

            modelBuilder.Entity<Cast>().HasData(

 new Cast { CastId = "CAST001", Name = "Robert Downey Jr.", AvatarUrl = "https://image.tmdb.org/t/p/w500/1YjdSym1jTG7xjHSI0yGGWEsw5i.jpg" },

 new Cast { CastId = "CAST002", Name = "Chris Evans", AvatarUrl = "https://image.tmdb.org/t/p/w500/3bOGNsHlrswhyW79uvIHH1V43JI.jpg" },

 new Cast { CastId = "CAST003", Name = "Scarlett Johansson", AvatarUrl = "https://image.tmdb.org/t/p/w500/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg" },

 new Cast { CastId = "CAST004", Name = "Tom Holland", AvatarUrl = "https://image.tmdb.org/t/p/w500/2qhIDp44cAqP2clOgt2afQI07X8.jpg" },

 new Cast { CastId = "CAST005", Name = "Zendaya", AvatarUrl = "https://image.tmdb.org/t/p/w500/soCzE1b0E4W3F7h2mXc4L0bXc2n.jpg" },

 new Cast { CastId = "CAST006", Name = "Robert Pattinson", AvatarUrl = "https://image.tmdb.org/t/p/w500/8A4PS5iG7GWEAVFftyqMZKl3lbA.jpg" },

 new Cast { CastId = "CAST007", Name = "Zoe Kravitz", AvatarUrl = "https://image.tmdb.org/t/p/w500/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg" },

 new Cast { CastId = "CAST008", Name = "Benedict Cumberbatch", AvatarUrl = "https://image.tmdb.org/t/p/w500/fBEucxECxGLKVHBznO0qHtCGiMO.jpg" },

 new Cast { CastId = "CAST009", Name = "Elizabeth Olsen", AvatarUrl = "https://image.tmdb.org/t/p/w500/wIU675y4lOQMj2mc7vo5Wy7Z8bZ.jpg" },

 new Cast { CastId = "CAST010", Name = "Ryan Reynolds", AvatarUrl = "https://image.tmdb.org/t/p/w500/4SYTH5FdB0dAORV98Nwg3llgVnY.jpg" }

 );

            // ========================
            // SEED MOVIE CAST
            // ========================

            modelBuilder.Entity<MovieCast>().HasData(

                new MovieCast { MovieId = "MOV001", CastId = "CAST001", CharacterName = "Iron Man", CharacterAvatar = "" },
                new MovieCast { MovieId = "MOV001", CastId = "CAST002", CharacterName = "Captain America", CharacterAvatar = "" },
                new MovieCast { MovieId = "MOV001", CastId = "CAST003", CharacterName = "Black Widow", CharacterAvatar = "" },

                new MovieCast { MovieId = "MOV002", CastId = "CAST004", CharacterName = "Spider-Man", CharacterAvatar = "" },
                new MovieCast { MovieId = "MOV002", CastId = "CAST005", CharacterName = "MJ", CharacterAvatar = "" },

                new MovieCast { MovieId = "MOV003", CastId = "CAST006", CharacterName = "Batman", CharacterAvatar = "" },
                new MovieCast { MovieId = "MOV003", CastId = "CAST007", CharacterName = "Catwoman", CharacterAvatar = "" },

                new MovieCast { MovieId = "MOV004", CastId = "CAST008", CharacterName = "Doctor Strange", CharacterAvatar = "" },
                new MovieCast { MovieId = "MOV004", CastId = "CAST009", CharacterName = "Scarlet Witch", CharacterAvatar = "" },

                new MovieCast { MovieId = "MOV005", CastId = "CAST010", CharacterName = "Deadpool", CharacterAvatar = "" }

            );

            modelBuilder.Entity<Genre>().HasData(

                new Genre { GenreId = "GEN001", Name = "Action", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN002", Name = "Adventure", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN003", Name = "Animation", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN004", Name = "Biography", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN005", Name = "Comedy", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },

                new Genre { GenreId = "GEN006", Name = "Crime", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN007", Name = "Documentary", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN008", Name = "Drama", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN009", Name = "Family", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN010", Name = "Fantasy", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },

                new Genre { GenreId = "GEN011", Name = "History", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN012", Name = "Horror", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN013", Name = "Music", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN014", Name = "Mystery", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN015", Name = "Romance", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },

                new Genre { GenreId = "GEN016", Name = "Sci-Fi", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN017", Name = "Sport", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN018", Name = "Thriller", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN019", Name = "War", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN020", Name = "Western", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },

                new Genre { GenreId = "GEN021", Name = "Superhero", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN022", Name = "Psychological", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN023", Name = "Anime", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN024", Name = "Disaster", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
                new Genre { GenreId = "GEN025", Name = "Martial Arts", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) }

            );
            modelBuilder.Entity<MovieGenre>().HasData(

                new MovieGenre { MovieId = "MOV001", GenreId = "GEN001" }, // Action
                new MovieGenre { MovieId = "MOV001", GenreId = "GEN021" }, // Superhero
                new MovieGenre { MovieId = "MOV001", GenreId = "GEN016" }, // Sci-Fi

                new MovieGenre { MovieId = "MOV002", GenreId = "GEN002" }, // Adventure
                new MovieGenre { MovieId = "MOV002", GenreId = "GEN010" }, // Fantasy

                new MovieGenre { MovieId = "MOV003", GenreId = "GEN015" }, // Romance
                new MovieGenre { MovieId = "MOV003", GenreId = "GEN008" }, // Drama

                new MovieGenre { MovieId = "MOV004", GenreId = "GEN012" }, // Horror
                new MovieGenre { MovieId = "MOV004", GenreId = "GEN018" }, // Thriller

                new MovieGenre { MovieId = "MOV005", GenreId = "GEN005" }, // Comedy
                new MovieGenre { MovieId = "MOV005", GenreId = "GEN009" }, // Family

                new MovieGenre { MovieId = "MOV006", GenreId = "GEN016" }, // Sci-Fi
                new MovieGenre { MovieId = "MOV006", GenreId = "GEN018" }, // Thriller

                new MovieGenre { MovieId = "MOV007", GenreId = "GEN001" }, // Action
                new MovieGenre { MovieId = "MOV007", GenreId = "GEN002" }, // Adventure

                new MovieGenre { MovieId = "MOV008", GenreId = "GEN023" }, // Anime
                new MovieGenre { MovieId = "MOV008", GenreId = "GEN003" }, // Animation

                new MovieGenre { MovieId = "MOV009", GenreId = "GEN004" }, // Biography
                new MovieGenre { MovieId = "MOV009", GenreId = "GEN008" }, // Drama

                new MovieGenre { MovieId = "MOV010", GenreId = "GEN024" }, // Disaster
                new MovieGenre { MovieId = "MOV010", GenreId = "GEN018" }  // Thriller

            );
            modelBuilder.Entity<Role>().HasData(

                new Role
                {
                    RoleId = "ROLE001",
                    Name = "ADMIN"
                },

                new Role
                {
                    RoleId = "ROLE002",
                    Name = "CUSTOMER"
                }

            );

            modelBuilder.Entity<User>().HasData(

                new User
                {
                    UserId = "USR001",
                    Phone = "0900000001",
                    Email = "john@example.com",
                    PasswordHash = "123456",
                    FullName = "John Smith",
                    AvatarUrl = "https://i.pravatar.cc/150?img=1",
                    Status = "ACTIVE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1),
                    RoleId = "ROLE002"
                },

                new User
                {
                    UserId = "USR002",
                    Phone = "0900000002",
                    Email = "emma@example.com",
                    PasswordHash = "123456",
                    FullName = "Emma Watson",
                    AvatarUrl = "https://i.pravatar.cc/150?img=2",
                    Status = "ACTIVE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1),
                    RoleId = "ROLE002"
                },

                new User
                {
                    UserId = "USR003",
                    Phone = "0900000003",
                    Email = "robert@example.com",
                    PasswordHash = "123456",
                    FullName = "Robert Downey Jr",
                    AvatarUrl = "https://i.pravatar.cc/150?img=3",
                    Status = "ACTIVE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1),
                    RoleId = "ROLE002"
                },

                new User
                {
                    UserId = "USR004",
                    Phone = "0900000004",
                    Email = "scarlett@example.com",
                    PasswordHash = "123456",
                    FullName = "Scarlett Johansson",
                    AvatarUrl = "https://i.pravatar.cc/150?img=4",
                    Status = "ACTIVE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1),
                    RoleId = "ROLE002"
                },

                new User
                {
                    UserId = "USR005",
                    Phone = "0900000005",
                    Email = "chris@example.com",
                    PasswordHash = "123456",
                    FullName = "Chris Evans",
                    AvatarUrl = "https://i.pravatar.cc/150?img=5",
                    Status = "ACTIVE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1),
                    RoleId = "ROLE002"
                }

            );

            modelBuilder.Entity<MovieRating>().HasData(

                new MovieRating { MovieRatingId = "RAT001", MovieId = "MOV001", UserId = "USR001", Stars = 5 },
                new MovieRating { MovieRatingId = "RAT002", MovieId = "MOV001", UserId = "USR002", Stars = 4 },

                new MovieRating { MovieRatingId = "RAT003", MovieId = "MOV002", UserId = "USR003", Stars = 3 },
                new MovieRating { MovieRatingId = "RAT004", MovieId = "MOV002", UserId = "USR004", Stars = 5 }
            );
            modelBuilder.Entity<Poster>().HasData(

new Poster { PosterId = "POS001", Title = "Avengers Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg", MovieId = "MOV001" },

new Poster { PosterId = "POS002", Title = "Spider-Man Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", MovieId = "MOV002" },

new Poster { PosterId = "POS003", Title = "Batman Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg", MovieId = "MOV003" },

new Poster { PosterId = "POS004", Title = "Doctor Strange Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", MovieId = "MOV004" },

new Poster { PosterId = "POS005", Title = "Deadpool Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg", MovieId = "MOV005" },

new Poster { PosterId = "POS006", Title = "Joker Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg", MovieId = "MOV006" },

new Poster { PosterId = "POS007", Title = "Kung Fu Panda Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg", MovieId = "MOV007" },

new Poster { PosterId = "POS008", Title = "Mission Impossible Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg", MovieId = "MOV008" },

new Poster { PosterId = "POS009", Title = "Avatar Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg", MovieId = "MOV009" },

new Poster { PosterId = "POS010", Title = "Top Gun Poster", ImageUrl = "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg", MovieId = "MOV010" }

            );
            modelBuilder.Entity<WatchList>().HasData(

                new WatchList { WatchListId = "WL001", UserId = "USR001", MovieId = "MOV001", type = "FAVORITE", CreatedAt = new DateTime(2026, 1, 1) },
                new WatchList { WatchListId = "WL002", UserId = "USR001", MovieId = "MOV003", type = "FAVORITE", CreatedAt = new DateTime(2026, 1, 1) },

                new WatchList { WatchListId = "WL003", UserId = "USR002", MovieId = "MOV002", type = "WATCH_LATER", CreatedAt = new DateTime(2026, 1, 1) },
                new WatchList { WatchListId = "WL004", UserId = "USR002", MovieId = "MOV005", type = "WATCH_LATER", CreatedAt = new DateTime(2026, 1, 1) },

                new WatchList { WatchListId = "WL005", UserId = "USR003", MovieId = "MOV004", type = "FAVORITE", CreatedAt = new DateTime(2026, 1, 1) },
                new WatchList { WatchListId = "WL006", UserId = "USR003", MovieId = "MOV007", type = "WATCH_LATER", CreatedAt = new DateTime(2026, 1, 1) },

                new WatchList { WatchListId = "WL007", UserId = "USR004", MovieId = "MOV006", type = "FAVORITE", CreatedAt = new DateTime(2026, 1, 1) },
                new WatchList { WatchListId = "WL008", UserId = "USR004", MovieId = "MOV008", type = "WATCH_LATER", CreatedAt = new DateTime(2026, 1, 1) },

                new WatchList { WatchListId = "WL009", UserId = "USR005", MovieId = "MOV009", type = "FAVORITE", CreatedAt = new DateTime(2026, 1, 1) },
                new WatchList { WatchListId = "WL010", UserId = "USR005", MovieId = "MOV010", type = "WATCH_LATER", CreatedAt = new DateTime(2026, 1, 1) }

            );

            modelBuilder.Entity<BlogPost>().HasData(

                new BlogPost
                {
                    BlogPostId = "BLOG001",
                    UserId = "USR001",
                    Title = "Top 10 Marvel Movies You Must Watch",
                    Content = "Marvel movies have changed the superhero genre forever...",
                    ImageUrl = "https://images.unsplash.com/photo-1",
                    Likes = 120,
                    CreatedDate = new DateTime(2026, 1, 1),
                },

                new BlogPost
                {
                    BlogPostId = "BLOG002",
                    UserId = "USR002",
                    Title = "Why Horror Movies Are So Popular",
                    Content = "Horror movies give audiences a thrilling experience...",
                    ImageUrl = "https://images.unsplash.com/photo-2",
                    Likes = 85,
                    CreatedDate = new DateTime(2026, 1, 1),
                },

                new BlogPost
                {
                    BlogPostId = "BLOG003",
                    UserId = "USR003",
                    Title = "Best Sci-Fi Movies of the Decade",
                    Content = "Science fiction movies explore the future and technology...",
                    ImageUrl = "https://images.unsplash.com/photo-3",
                    Likes = 95,
                    CreatedDate = new DateTime(2026, 1, 1),
                },

                new BlogPost
                {
                    BlogPostId = "BLOG004",
                    UserId = "USR004",
                    Title = "Romantic Movies Perfect for Date Night",
                    Content = "These romantic films will make your evening unforgettable...",
                    ImageUrl = "https://images.unsplash.com/photo-4",
                    Likes = 60,
                    CreatedDate = new DateTime(2026, 1, 1),
                },

                new BlogPost
                {
                    BlogPostId = "BLOG005",
                    UserId = "USR005",
                    Title = "Upcoming Blockbusters in 2026",
                    Content = "Many exciting movies are coming to theaters next year...",
                    ImageUrl = "https://images.unsplash.com/photo-5",
                    Likes = 150,
                    CreatedDate = new DateTime(2026, 1, 1),
                }

            );
            modelBuilder.Entity<Comment>().HasData(

                new Comment { CommentId = "CMT001", UserId = "USR002", BlogPostId = "BLOG001", Content = "Great list! I love Marvel movies.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT002", UserId = "USR003", BlogPostId = "BLOG001", Content = "Avengers Endgame is my favorite.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT003", UserId = "USR004", BlogPostId = "BLOG001", Content = "Nice recommendations!", CreatedDate = new DateTime(2026, 1, 1), },

                new Comment { CommentId = "CMT004", UserId = "USR001", BlogPostId = "BLOG002", Content = "Horror movies are so thrilling!", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT005", UserId = "USR005", BlogPostId = "BLOG002", Content = "The Conjuring series is amazing.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT006", UserId = "USR003", BlogPostId = "BLOG002", Content = "I love watching horror at night.", CreatedDate = new DateTime(2026, 1, 1), },

                new Comment { CommentId = "CMT007", UserId = "USR001", BlogPostId = "BLOG003", Content = "Interstellar is a masterpiece.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT008", UserId = "USR002", BlogPostId = "BLOG003", Content = "Sci-Fi movies inspire imagination.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT009", UserId = "USR005", BlogPostId = "BLOG003", Content = "I love futuristic technology.", CreatedDate = new DateTime(2026, 1, 1), },

                new Comment { CommentId = "CMT010", UserId = "USR003", BlogPostId = "BLOG004", Content = "Perfect movies for couples.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT011", UserId = "USR002", BlogPostId = "BLOG004", Content = "Titanic will always be iconic.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT012", UserId = "USR001", BlogPostId = "BLOG004", Content = "Romantic movies are emotional.", CreatedDate = new DateTime(2026, 1, 1), },

                new Comment { CommentId = "CMT013", UserId = "USR004", BlogPostId = "BLOG005", Content = "Can't wait for next year's movies!", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT014", UserId = "USR003", BlogPostId = "BLOG005", Content = "So many exciting releases.", CreatedDate = new DateTime(2026, 1, 1), },
                new Comment { CommentId = "CMT015", UserId = "USR002", BlogPostId = "BLOG005", Content = "Hope Marvel releases new films!", CreatedDate = new DateTime(2026, 1, 1), }

            );
            modelBuilder.Entity<Cinema>().HasData(

                 new Cinema
                 {
                     CinemaId = "C001",
                     Name = "CGV Vincom Ba Trieu",
                     Location = "Ha Noi",
                     Rating = "4.5",
                     Hotline = "19006017",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },

                 new Cinema
                 {
                     CinemaId = "C002",
                     Name = "Lotte Cinema Landmark",
                     Location = "Ha Noi",
                     Rating = "4.6",
                     Hotline = "1900558899",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },

                 new Cinema
                 {
                     CinemaId = "C003",
                     Name = "BHD Star Pham Ngoc Thach",
                     Location = "Ha Noi",
                     Rating = "4.4",
                     Hotline = "19002099",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },

                 new Cinema
                 {
                     CinemaId = "C004",
                     Name = "Platinum Cineplex Royal City",
                     Location = "Ha Noi",
                     Rating = "4.7",
                     Hotline = "02466649019",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },

                 new Cinema
                 {
                     CinemaId = "C005",
                     Name = "Beta Cinemas Dan Phuong",
                     Location = "Ha Noi",
                     Rating = "4.2",
                     Hotline = "1800646420",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },

                 new Cinema
                 {
                     CinemaId = "C006",
                     Name = "Galaxy Cinema Mipec",
                     Location = "Ha Noi",
                     Rating = "4.3",
                     Hotline = "19002224",
                     CreatedAt = new DateTime(2024, 1, 1),
                     UpdatedAt = new DateTime(2024, 1, 1)
                 },
                 new Cinema { CinemaId = "C007", Name = "National Cinema Center", Location = "Ha Noi", Rating = "4.1", Hotline = "02435141791", CreatedAt = new DateTime(2024, 1, 1), UpdatedAt = new DateTime(2024, 1, 1) },
                 new Cinema { CinemaId = "C008", Name = "Galaxy Cinema Nguyen Du", Location = "Ho Chi Minh", Rating = "4.1", Hotline = "19002224", CreatedAt = new DateTime(2024, 1, 1), UpdatedAt = new DateTime(2024, 1, 1) },
                 new Cinema { CinemaId = "C009", Name = "CGV Gigamall Thu Duc", Location = "Ho Chi Minh", Rating = "4.5", Hotline = "19006017", CreatedAt = new DateTime(2024, 1, 1), UpdatedAt = new DateTime(2024, 1, 1) },
                 new Cinema { CinemaId = "C010", Name = "Lotte Cinema Cantavil", Location = "Ho Chi Minh", Rating = "4.2", Hotline = "02837402323", CreatedAt = new DateTime(2024, 1, 1), UpdatedAt = new DateTime(2024, 1, 1) }
            );
            modelBuilder.Entity<Room>().HasData(

               new Room
               {
                   RoomId = "R001",
                   Name = "Auditorium 1",
                   CinemaId = "C001"
               },

               new Room
               {
                   RoomId = "R002",
                   Name = "Auditorium 2",
                   CinemaId = "C001"
               },

               new Room
               {
                   RoomId = "R003",
                   Name = "Auditorium 3",
                   CinemaId = "C001"
               },

               new Room
               {
                   RoomId = "R004",
                   Name = "Auditorium 4",
                   CinemaId = "C001"
               },

               new Room
               {
                   RoomId = "R005",
                   Name = "Auditorium 5",
                   CinemaId = "C001"
               },

               new Room
               {
                   RoomId = "R006",
                   Name = "Auditorium 1",
                   CinemaId = "C002"
               },

               new Room
               {
                   RoomId = "R007",
                   Name = "Auditorium 2",
                   CinemaId = "C002"
               },

               new Room
               {
                   RoomId = "R008",
                   Name = "Auditorium 3",
                   CinemaId = "C002"
               },

               new Room
               {
                   RoomId = "R009",
                   Name = "Auditorium 4",
                   CinemaId = "C002"
               },

               new Room
               {
                   RoomId = "R010",
                   Name = "Auditorium 5",
                   CinemaId = "C002"
               },

               new Room
               {
                   RoomId = "R011",
                   Name = "Auditorium 1",
                   CinemaId = "C003"
               },

               new Room
               {
                   RoomId = "R012",
                   Name = "Auditorium 2",
                   CinemaId = "C003"
               },

               new Room
               {
                   RoomId = "R013",
                   Name = "Auditorium 3",
                   CinemaId = "C003"
               },

               new Room
               {
                   RoomId = "R014",
                   Name = "Auditorium 4",
                   CinemaId = "C003"
               },

               new Room
               {
                   RoomId = "R015",
                   Name = "Auditorium 5",
                   CinemaId = "C003"
               },
                new Room { RoomId = "R016", Name = "Room 1", CinemaId = "C004" },
                new Room { RoomId = "R017", Name = "Room 2", CinemaId = "C004" },
                new Room { RoomId = "R018", Name = "Room 3", CinemaId = "C004" },
                new Room { RoomId = "R019", Name = "Room 4", CinemaId = "C004" },
                new Room { RoomId = "R020", Name = "Room 5", CinemaId = "C004" },
                new Room { RoomId = "R021", Name = "Room 1", CinemaId = "C005" },
                new Room { RoomId = "R022", Name = "Room 2", CinemaId = "C005" },
                new Room { RoomId = "R023", Name = "Room 3", CinemaId = "C005" },
                new Room { RoomId = "R024", Name = "Room 4", CinemaId = "C005" },
                new Room { RoomId = "R025", Name = "Room 5", CinemaId = "C005" },
                new Room { RoomId = "R026", Name = "Room 1", CinemaId = "C006" },
                new Room { RoomId = "R027", Name = "Room 2", CinemaId = "C006" },
                new Room { RoomId = "R028", Name = "Room 3", CinemaId = "C006" },
                 new Room { RoomId = "R029", Name = "Room 4", CinemaId = "C006" },
                 new Room { RoomId = "R030", Name = "Room 5", CinemaId = "C006" },
                 new Room { RoomId = "R031", Name = "Room 1", CinemaId = "C007" },
                 new Room { RoomId = "R032", Name = "Room 1", CinemaId = "C008" },
                 new Room { RoomId = "R033", Name = "Room 1", CinemaId = "C009" },
                 new Room { RoomId = "R034", Name = "Room 1", CinemaId = "C010" }
           );

            modelBuilder.Entity<Showtime>().HasData(

                // STANDARD
                new Showtime
                {
                    ShowtimeId = "ST001",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 10, 10, 0, 0),
                    EndTime = new DateTime(2026, 6, 10, 12, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST002",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 10, 12, 30, 0),
                    EndTime = new DateTime(2026, 6, 10, 14, 30, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST003",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 10, 15, 0, 0),
                    EndTime = new DateTime(2026, 6, 10, 17, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST004",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 10, 17, 30, 0),
                    EndTime = new DateTime(2026, 6, 10, 19, 30, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },


                // IMAX
                new Showtime
                {
                    ShowtimeId = "ST005",
                    MovieId = "MOV001",
                    RoomId = "R002",
                    StartTime = new DateTime(2026, 6, 10, 11, 0, 0),
                    EndTime = new DateTime(2026, 6, 10, 13, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST006",
                    MovieId = "MOV001",
                    RoomId = "R002",
                    StartTime = new DateTime(2026, 6, 10, 13, 0, 0),
                    EndTime = new DateTime(2026, 6, 10, 15, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },


                // Dolby
                new Showtime
                {
                    ShowtimeId = "ST007",
                    MovieId = "MOV001",
                    RoomId = "R003",
                    StartTime = new DateTime(2026, 6, 10, 12, 0, 0),
                    EndTime = new DateTime(2026, 6, 10, 14, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                    new Showtime
                    {
                        ShowtimeId = "ST008",
                        MovieId = "MOV001",
                        RoomId = "R001",
                        StartTime = new DateTime(2026, 6, 23, 10, 0, 0),
                        EndTime = new DateTime(2026, 6, 23, 12, 0, 0),
                        Status = "AVAILABLE",
                        CreatedAt = new DateTime(2026, 1, 1),
                        UpdatedAt = new DateTime(2026, 1, 1)
                    },

                new Showtime
                {
                    ShowtimeId = "ST009",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 23, 12, 30, 0),
                    EndTime = new DateTime(2026, 6, 23, 14, 30, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                // IMAX
                new Showtime
                {
                    ShowtimeId = "ST010",
                    MovieId = "MOV001",
                    RoomId = "R002",
                    StartTime = new DateTime(2026, 6, 23, 11, 0, 0),
                    EndTime = new DateTime(2026, 6, 23, 13, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                // DOLBY
                new Showtime
                {
                    ShowtimeId = "ST011",
                    MovieId = "MOV001",
                    RoomId = "R003",
                    StartTime = new DateTime(2026, 6, 23, 12, 0, 0),
                    EndTime = new DateTime(2026, 6, 23, 14, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST012",
                    MovieId = "MOV001",
                    RoomId = "R001",
                    StartTime = new DateTime(2026, 6, 24, 10, 0, 0),
                    EndTime = new DateTime(2026, 6, 24, 12, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST013",
                    MovieId = "MOV001",
                    RoomId = "R002",
                    StartTime = new DateTime(2026, 6, 24, 11, 0, 0),
                    EndTime = new DateTime(2026, 6, 24, 13, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },

                new Showtime
                {
                    ShowtimeId = "ST014",
                    MovieId = "MOV001",
                    RoomId = "R003",
                    StartTime = new DateTime(2026, 6, 24, 12, 0, 0),
                    EndTime = new DateTime(2026, 6, 24, 14, 0, 0),
                    Status = "AVAILABLE",
                    CreatedAt = new DateTime(2026, 1, 1),
                    UpdatedAt = new DateTime(2026, 1, 1)
                },
                // ================= MOV002 =================
new Showtime
{
    ShowtimeId = "ST101",
    MovieId = "MOV002",
    RoomId = "R001",
    StartTime = new DateTime(2026, 6, 23, 10, 0, 0),
    EndTime = new DateTime(2026, 6, 23, 12, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = new DateTime(2026, 1, 1),
    UpdatedAt = new DateTime(2026, 1, 1)
},

new Showtime
{
    ShowtimeId = "ST102",
    MovieId = "MOV002",
    RoomId = "R002",
    StartTime = new DateTime(2026, 6, 23, 13, 0, 0),
    EndTime = new DateTime(2026, 6, 23, 15, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = new DateTime(2026, 1, 1),
    UpdatedAt = new DateTime(2026, 1, 1)
},

// ================= MOV003 =================
new Showtime
{
    ShowtimeId = "ST103",
    MovieId = "MOV003",
    RoomId = "R003",
    StartTime = new DateTime(2026, 6, 23, 10, 0, 0),
    EndTime = new DateTime(2026, 6, 23, 12, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = new DateTime(2026, 1, 1),
    UpdatedAt = new DateTime(2026, 1, 1)
},

// ================= MOV004 → MOV010 =================
new Showtime { ShowtimeId = "ST104", MovieId = "MOV004", RoomId = "R001", StartTime = new DateTime(2026, 6, 23, 10, 0, 0), EndTime = new DateTime(2026, 6, 23, 12, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST105", MovieId = "MOV005", RoomId = "R002", StartTime = new DateTime(2026, 6, 23, 10, 0, 0), EndTime = new DateTime(2026, 6, 23, 12, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST106", MovieId = "MOV006", RoomId = "R003", StartTime = new DateTime(2026, 6, 23, 10, 0, 0), EndTime = new DateTime(2026, 6, 23, 12, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST107", MovieId = "MOV007", RoomId = "R001", StartTime = new DateTime(2026, 6, 23, 13, 0, 0), EndTime = new DateTime(2026, 6, 23, 15, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST108", MovieId = "MOV008", RoomId = "R002", StartTime = new DateTime(2026, 6, 23, 13, 0, 0), EndTime = new DateTime(2026, 6, 23, 15, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST109", MovieId = "MOV009", RoomId = "R003", StartTime = new DateTime(2026, 6, 23, 13, 0, 0), EndTime = new DateTime(2026, 6, 23, 15, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
new Showtime { ShowtimeId = "ST110", MovieId = "MOV010", RoomId = "R001", StartTime = new DateTime(2026, 6, 23, 16, 0, 0), EndTime = new DateTime(2026, 6, 23, 18, 0, 0), Status = "AVAILABLE", CreatedAt = new DateTime(2026, 1, 1), UpdatedAt = new DateTime(2026, 1, 1) },
// ===== MOV001 - C001 =====
new Showtime
{
    ShowtimeId = "ST201",
    MovieId = "MOV001",
    RoomId = "R001", // C001
    StartTime = new DateTime(2026, 6, 25, 10, 0, 0),
    EndTime = new DateTime(2026, 6, 25, 12, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = DateTime.Now,
    UpdatedAt = DateTime.Now
},

// ===== MOV001 - C002 =====
new Showtime
{
    ShowtimeId = "ST202",
    MovieId = "MOV001",
    RoomId = "R006", // C002
    StartTime = new DateTime(2026, 6, 25, 13, 0, 0),
    EndTime = new DateTime(2026, 6, 25, 15, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = DateTime.Now,
    UpdatedAt = DateTime.Now
},

// ===== MOV001 - C003 =====
new Showtime
{
    ShowtimeId = "ST203",
    MovieId = "MOV001",
    RoomId = "R011", // C003
    StartTime = new DateTime(2026, 6, 25, 16, 0, 0),
    EndTime = new DateTime(2026, 6, 25, 18, 0, 0),
    Status = "AVAILABLE",
    CreatedAt = DateTime.Now,
    UpdatedAt = DateTime.Now
},
new Showtime { ShowtimeId = "ST204", MovieId = "MOV002", RoomId = "R001", StartTime = new DateTime(2026, 6, 25, 10, 0, 0), EndTime = new DateTime(2026, 6, 25, 12, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST205", MovieId = "MOV003", RoomId = "R006", StartTime = new DateTime(2026, 6, 25, 12, 30, 0), EndTime = new DateTime(2026, 6, 25, 14, 30, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST206", MovieId = "MOV004", RoomId = "R011", StartTime = new DateTime(2026, 6, 25, 15, 0, 0), EndTime = new DateTime(2026, 6, 25, 17, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST207", MovieId = "MOV005", RoomId = "R002", StartTime = new DateTime(2026, 6, 25, 10, 0, 0), EndTime = new DateTime(2026, 6, 25, 12, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST208", MovieId = "MOV006", RoomId = "R007", StartTime = new DateTime(2026, 6, 25, 13, 0, 0), EndTime = new DateTime(2026, 6, 25, 15, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST209", MovieId = "MOV007", RoomId = "R012", StartTime = new DateTime(2026, 6, 25, 16, 0, 0), EndTime = new DateTime(2026, 6, 25, 18, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST210", MovieId = "MOV008", RoomId = "R003", StartTime = new DateTime(2026, 6, 25, 10, 0, 0), EndTime = new DateTime(2026, 6, 25, 12, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST211", MovieId = "MOV009", RoomId = "R008", StartTime = new DateTime(2026, 6, 25, 13, 0, 0), EndTime = new DateTime(2026, 6, 25, 15, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now },
new Showtime { ShowtimeId = "ST212", MovieId = "MOV010", RoomId = "R013", StartTime = new DateTime(2026, 6, 25, 16, 0, 0), EndTime = new DateTime(2026, 6, 25, 18, 0, 0), Status = "AVAILABLE", CreatedAt = DateTime.Now, UpdatedAt = DateTime.Now }
            );

            modelBuilder.Entity<TicketType>().HasData(

                new TicketType
                {
                    TicketTypeId = "TT001",
                    Name = "Standard",
                    Status = "ACTIVE"
                },

                new TicketType
                {
                    TicketTypeId = "TT002",
                    Name = "IMAX",
                    Status = "ACTIVE"
                },

                new TicketType
                {
                    TicketTypeId = "TT003",
                    Name = "Dolby Cinema",
                    Status = "ACTIVE"
                }

            );

            modelBuilder.Entity<ShowtimeTicketType>().HasData(

                // STANDARD
                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT001",
                    ShowtimeId = "ST001",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT002",
                    ShowtimeId = "ST002",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT003",
                    ShowtimeId = "ST003",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT004",
                    ShowtimeId = "ST004",
                    TicketTypeId = "TT001",
                    Price = 120000
                },


                // IMAX
                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT005",
                    ShowtimeId = "ST005",
                    TicketTypeId = "TT002",
                    Price = 170000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT006",
                    ShowtimeId = "ST006",
                    TicketTypeId = "TT002",
                    Price = 170000
                },


                // Dolby
                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT007",
                    ShowtimeId = "ST007",
                    TicketTypeId = "TT003",
                    Price = 220000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT008",
                    ShowtimeId = "ST008",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT009",
                    ShowtimeId = "ST009",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT010",
                    ShowtimeId = "ST010",
                    TicketTypeId = "TT002",
                    Price = 170000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT011",
                    ShowtimeId = "ST011",
                    TicketTypeId = "TT003",
                    Price = 220000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT012",
                    ShowtimeId = "ST012",
                    TicketTypeId = "TT001",
                    Price = 120000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT013",
                    ShowtimeId = "ST013",
                    TicketTypeId = "TT002",
                    Price = 170000
                },

                new ShowtimeTicketType
                {
                    ShowtimeTicketTypeId = "STT014",
                    ShowtimeId = "ST014",
                    TicketTypeId = "TT003",
                    Price = 220000
                },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT101", ShowtimeId = "ST101", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT102", ShowtimeId = "ST102", TicketTypeId = "TT002", Price = 170000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT103", ShowtimeId = "ST103", TicketTypeId = "TT003", Price = 220000 },

new ShowtimeTicketType { ShowtimeTicketTypeId = "STT104", ShowtimeId = "ST104", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT105", ShowtimeId = "ST105", TicketTypeId = "TT002", Price = 170000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT106", ShowtimeId = "ST106", TicketTypeId = "TT003", Price = 220000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT107", ShowtimeId = "ST107", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT108", ShowtimeId = "ST108", TicketTypeId = "TT002", Price = 170000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT109", ShowtimeId = "ST109", TicketTypeId = "TT003", Price = 220000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT110", ShowtimeId = "ST110", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT201", ShowtimeId = "ST201", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT202", ShowtimeId = "ST202", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT203", ShowtimeId = "ST203", TicketTypeId = "TT001", Price = 120000 },

new ShowtimeTicketType { ShowtimeTicketTypeId = "STT204", ShowtimeId = "ST204", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT205", ShowtimeId = "ST205", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT206", ShowtimeId = "ST206", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT207", ShowtimeId = "ST207", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT208", ShowtimeId = "ST208", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT209", ShowtimeId = "ST209", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT210", ShowtimeId = "ST210", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT211", ShowtimeId = "ST211", TicketTypeId = "TT001", Price = 120000 },
new ShowtimeTicketType { ShowtimeTicketTypeId = "STT212", ShowtimeId = "ST212", TicketTypeId = "TT001", Price = 120000 }
            );
            modelBuilder.Entity<FoodCombo>().HasData(

     new FoodCombo
     {
         FoodComboId = "FC001",
         Name = "Popcorn + Coke",
         Description = "1 Large Popcorn + 1 Coke",
         Status = "ACTIVE",
         Price = 75000,
         ImageUrl = "https://image.tmdb.org/t/p/w500/wWt4JYXTg5Wr3xBW2phBrMKgp3x.jpg",
         CreatedDate = new DateTime(2024, 1, 1),
         UpdatedDate = new DateTime(2024, 1, 1)
     },

     new FoodCombo
     {
         FoodComboId = "FC002",
         Name = "Couple Combo",
         Description = "1 Large Popcorn + 2 Drinks",
         Status = "ACTIVE",
         Price = 120000,
         ImageUrl = "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
         CreatedDate = new DateTime(2024, 1, 1),
         UpdatedDate = new DateTime(2024, 1, 1)
     },

     new FoodCombo
     {
         FoodComboId = "FC003",
         Name = "Family Combo",
         Description = "2 Large Popcorn + 4 Drinks",
         Status = "ACTIVE",
         Price = 200000,
         ImageUrl = "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg",
         CreatedDate = new DateTime(2024, 1, 1),
         UpdatedDate = new DateTime(2024, 1, 1)
     },

     new FoodCombo
     {
         FoodComboId = "FC004",
         Name = "Nachos Combo",
         Description = "Nachos + 1 Coke",
         Status = "ACTIVE",
         Price = 85000,
         ImageUrl = "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
         CreatedDate = new DateTime(2024, 1, 1),
         UpdatedDate = new DateTime(2024, 1, 1)
     }
 );
            var seats = new List<Seat>();

            var rows = new[] { "A", "B", "C", "D", "E", "F", "G", "H" };
            var roomsList = Enumerable.Range(1, 34).Select(i => $"R{i:D3}").ToArray();

            int id = 1;

            foreach (var room in roomsList)
            {
                foreach (var row in rows)
                {
                    for (int col = 1; col <= 10; col++)
                    {
                        seats.Add(new Seat
                        {
                            SeatId = $"SE{id.ToString("D4")}",
                            SeatName = $"{row}{col}",
                            RoomId = room
                        });

                        id++;
                    }
                }
            }

            modelBuilder.Entity<Seat>().HasData(seats);


            modelBuilder.Entity<Voucher>().HasData(

                new Voucher
                {
                    VoucherId = "VC001",
                    Code = "WELCOME10",
                    Title = "Welcome Discount",
                    Description = "10% discount for new users",
                    Type = "PERCENTAGE",
                    Value = 10,
                    Status = "ACTIVE",
                    CreatedDate = new DateTime(2024, 1, 1),
                    ExpiredDate = new DateTime(2027, 1, 1)
                },

                new Voucher
                {
                    VoucherId = "VC002",
                    Code = "MOVIE50K",
                    Title = "50K Off",
                    Description = "Get 50,000 VND discount on booking",
                    Type = "FIX_AMOUNT",
                    Value = 50000,
                    Status = "ACTIVE",
                    CreatedDate = new DateTime(2024, 1, 1),
                    ExpiredDate = new DateTime(2027, 1, 1)
                },

                new Voucher
                {
                    VoucherId = "VC003",
                    Code = "WEEKEND20",
                    Title = "Weekend Discount",
                    Description = "20% off for weekend bookings",
                    Type = "PERCENTAGE",
                    Value = 20,
                    Status = "ACTIVE",
                    CreatedDate = new DateTime(2024, 1, 1),
                    ExpiredDate = new DateTime(2027, 1, 1)
                },

                new Voucher
                {
                    VoucherId = "VC004",
                    Code = "STUDENT15",
                    Title = "Student Offer",
                    Description = "15% discount for students",
                    Type = "PERCENTAGE",
                    Value = 15,
                    Status = "ACTIVE",
                    CreatedDate = new DateTime(2024, 1, 1),
                    ExpiredDate = new DateTime(2027, 1, 1)
                },

                new Voucher
                {
                    VoucherId = "VC005",
                    Code = "COMBO30",
                    Title = "Combo Discount",
                    Description = "30% off when buying food combo",
                    Type = "PERCENTAGE",
                    Value = 30,
                    Status = "ACTIVE",
                    CreatedDate = new DateTime(2024, 1, 1),
                    ExpiredDate = new DateTime(2027, 1, 1)
                }

            );

            modelBuilder.Entity<PostLike>().HasData(

        new PostLike { PostLikeId = "LIKE001", BlogPostId = "BLOG001", UserId = "USR001", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE002", BlogPostId = "BLOG001", UserId = "USR002", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE003", BlogPostId = "BLOG002", UserId = "USR003", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE004", BlogPostId = "BLOG003", UserId = "USR001", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE005", BlogPostId = "BLOG004", UserId = "USR005", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE006", BlogPostId = "BLOG002", UserId = "USR001", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE007", BlogPostId = "BLOG003", UserId = "USR002", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE008", BlogPostId = "BLOG004", UserId = "USR003", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE009", BlogPostId = "BLOG005", UserId = "USR004", CreatedAt = new DateTime(2026, 3, 25) },
        new PostLike { PostLikeId = "LIKE010", BlogPostId = "BLOG001", UserId = "USR005", CreatedAt = new DateTime(2026, 3, 25) }

        );

            modelBuilder.Entity<Booking>().HasData(

new Booking
{
    BookingId = "BK400",
    UserId = "USR002",
    ShowtimeId = "ST001",
    TotalAmount = 200000,
    Status = "CONFIRMED",
    CreatedAt = new DateTime(2026, 3, 25, 18, 59, 03)
},

new Booking
{
    BookingId = "BK401",
    UserId = "USR002",
    ShowtimeId = "ST002",
    TotalAmount = 300000,
    Status = "CONFIRMED",
    CreatedAt = new DateTime(2026, 3, 25, 18, 59, 03)
},

new Booking
{
    BookingId = "BK402",
    UserId = "USR002",
    ShowtimeId = "ST003",
    TotalAmount = 150000,
    Status = "CONFIRMED",
    CreatedAt = new DateTime(2026, 3, 25, 18, 59, 03)
},

new Booking
{
    BookingId = "BK403",
    UserId = "USR002",
    ShowtimeId = "ST004",
    TotalAmount = 400000,
    Status = "CONFIRMED",
    CreatedAt = new DateTime(2026, 3, 25, 18, 59, 03)
},

new Booking
{
    BookingId = "BK404",
    UserId = "USR002",
    ShowtimeId = "ST005",
    TotalAmount = 250000,
    Status = "CONFIRMED",
    CreatedAt = new DateTime(2026, 3, 25, 18, 59, 03)
},
new Booking
{
    BookingId = "BK405",
    UserId = "USR002",
    ShowtimeId = "ST015",
    TotalAmount = 120000,
    Status = "BOOKED",
    CreatedAt = new DateTime(2026, 3, 26, 10, 0, 0),
    OrderCode = 405001
},
new Booking
{
    BookingId = "BK406",
    UserId = "USR002",
    ShowtimeId = "ST017",
    TotalAmount = 240000,
    Status = "BOOKED",
    CreatedAt = new DateTime(2026, 3, 27, 15, 30, 0),
    OrderCode = 406001
}

);
            modelBuilder.Entity<BookingSeat>().HasData(

new BookingSeat { BookingSeatId = "BS400", BookingId = "BK400", SeatId = "SE0001", ShowtimeTicketTypeId = "STT001", Price = 100000, QrCode = "QR400", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },
new BookingSeat { BookingSeatId = "BS401", BookingId = "BK400", SeatId = "SE0002", ShowtimeTicketTypeId = "STT001", Price = 100000, QrCode = "QR401", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },

new BookingSeat { BookingSeatId = "BS402", BookingId = "BK401", SeatId = "SE0003", ShowtimeTicketTypeId = "STT001", Price = 150000, QrCode = "QR402", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },
new BookingSeat { BookingSeatId = "BS403", BookingId = "BK401", SeatId = "SE0004", ShowtimeTicketTypeId = "STT001", Price = 150000, QrCode = "QR403", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },

new BookingSeat { BookingSeatId = "BS404", BookingId = "BK402", SeatId = "SE0005", ShowtimeTicketTypeId = "STT001", Price = 75000, QrCode = "QR404", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },
new BookingSeat { BookingSeatId = "BS405", BookingId = "BK402", SeatId = "SE0006", ShowtimeTicketTypeId = "STT001", Price = 75000, QrCode = "QR405", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },

new BookingSeat { BookingSeatId = "BS406", BookingId = "BK403", SeatId = "SE0007", ShowtimeTicketTypeId = "STT001", Price = 200000, QrCode = "QR406", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },
new BookingSeat { BookingSeatId = "BS407", BookingId = "BK403", SeatId = "SE0008", ShowtimeTicketTypeId = "STT001", Price = 200000, QrCode = "QR407", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },

new BookingSeat { BookingSeatId = "BS408", BookingId = "BK404", SeatId = "SE0009", ShowtimeTicketTypeId = "STT001", Price = 125000, QrCode = "QR408", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) },
new BookingSeat { BookingSeatId = "BS409", BookingId = "BK404", SeatId = "SE0010", ShowtimeTicketTypeId = "STT001", Price = 125000, QrCode = "QR409", Status = "BOOKED", CheckinTime = new DateTime(2026, 3, 25) }

);
            modelBuilder.Entity<PaymentMethod>().HasData(
                new PaymentMethod
                {
                    PaymentMethodId = "PM001",
                    Name = "Credit Card",
                    ImageUrl = "https://example.com/creditcard.png",
                    Status = "ACTIVE",
                    CreatedDate = DateTime.Now,
                    UpdatedDate = DateTime.Now
                },
                new PaymentMethod
                {
                    PaymentMethodId = "PM002",
                    Name = "Momo",
                    ImageUrl = "https://example.com/momo.png",
                    Status = "ACTIVE",
                    CreatedDate = DateTime.Now,
                    UpdatedDate = DateTime.Now
                },
                new PaymentMethod
                {
                    PaymentMethodId = "PM003",
                    Name = "ZaloPay",
                    ImageUrl = "https://example.com/zalopay.png",
                    Status = "ACTIVE",
                    CreatedDate = DateTime.Now,
                    UpdatedDate = DateTime.Now
                }
            );
        }

    }
}
