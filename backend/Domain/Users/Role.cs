namespace Movie_Ticket_Booking_Backend.Domain.Users;

public class Role
{
    public string RoleId { get; set; }

    public string Name { get; set; }

    public ICollection<User> Users { get; set; }
}

