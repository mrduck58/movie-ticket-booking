using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Payment;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

namespace Movie_Ticket_Booking_Backend.Controllers.Payment
{
    [ApiController]
    [Route("api/payment-methods")]
    public class PaymentMethodController : ControllerBase
    {
        private readonly IPaymentMethodService _service;

        public PaymentMethodController(IPaymentMethodService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAll();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(string id)
        {
            try
            {
                var result = await _service.GetById(id);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Create(CreatePaymentMethodDto dto)
        {
            await _service.Create(dto);
            return Ok(new { message = "Payment method created" });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(string id, UpdatePaymentMethodDto dto)
        {
            try
            {
                await _service.Update(id, dto);
                return Ok(new { message = "Payment method updated" });
            }
            catch (Exception ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            try
            {
                await _service.Delete(id);
                return Ok(new { message = "Payment method deleted" });
            }
            catch (Exception ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }
    }
}
