using Azure.Core;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Payment;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

[ApiController]
[Route("api/payments")]
public class PaymentController : ControllerBase
{
    private readonly IPaymentService _paymentService;

    public PaymentController(IPaymentService paymentService)
    {
        _paymentService = paymentService;
    }

    [HttpPost]
    public async Task<IActionResult> Pay(CreatePaymentRequest request)
    {
        var result = await _paymentService.Pay(request.BookingId);

        if (!result)
            return BadRequest();

        return Ok();
    }
}