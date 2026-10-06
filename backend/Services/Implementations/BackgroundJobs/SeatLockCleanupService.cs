using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Movie_Ticket_Booking_Backend.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.BackgroundJobs
{
    public class SeatLockCleanupService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;

        public SeatLockCleanupService(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var scope = _serviceProvider.CreateScope())
                {
                    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

                    // Clear expired locks physically from the database
                    var expiredLocks = await dbContext.SeatLocks
                        .Where(sl => sl.ExpiredAt <= DateTime.UtcNow)
                        .ToListAsync(stoppingToken);

                    if (expiredLocks.Any())
                    {
                        dbContext.SeatLocks.RemoveRange(expiredLocks);
                        await dbContext.SaveChangesAsync(stoppingToken);
                    }
                }

                // Check every 30 seconds
                await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
            }
        }
    }
}
