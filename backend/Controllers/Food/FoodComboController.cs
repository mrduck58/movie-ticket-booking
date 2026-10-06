using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Foods;

namespace Movie_Ticket_Booking_Backend.Controllers.Food
{
    [ApiController]
    [Route("api/combos")]
    public class FoodComboController : Controller
    {
        private readonly IComboService _comboService;
        public FoodComboController(IComboService comboService)
        {
            _comboService = comboService;
        }
        [HttpGet]
        public async Task<IActionResult> GetCombos()
        {
            var combos = await _comboService.GetCombosAsync();
            return Ok(combos);
        }
    }
}
