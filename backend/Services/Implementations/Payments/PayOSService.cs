using Microsoft.Extensions.Configuration;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using PayOS;
using PayOS.Models.V2.PaymentRequests;
using PayOS.Models.Webhooks;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Payments
{
    public class PayOSService : Interfaces.Payments.IPayOSService
    {
        private readonly PayOSClient _client;
        private readonly IConfiguration _config;

        public PayOSService(IConfiguration config)
        {
            _config = config;
            _client = new PayOSClient(new PayOSOptions
            {
                ClientId    = _config["PayOS:ClientId"]    ?? throw new Exception("Missing PayOS:ClientId"),
                ApiKey      = _config["PayOS:ApiKey"]      ?? throw new Exception("Missing PayOS:ApiKey"),
                ChecksumKey = _config["PayOS:ChecksumKey"] ?? throw new Exception("Missing PayOS:ChecksumKey")
            });
        }

        public async Task<string> CreatePaymentLink(Booking booking)
        {
            // ================================================================
            // QUAN TRỌNG - expiredAt đồng bộ với SeatLock:
            // SeatLock được tạo trước khi Booking, với ExpiredAt = UtcNow + 5 phút.
            // Lúc tạo Booking ta lưu CreatedAt = UtcNow, nên:
            //   expiredAt = CreatedAt + 5 phút = thời điểm SeatLock hết hạn
            // => Link PayOS hết hạn đúng lúc ghế được nhả ra.
            // ================================================================
            var seatLockExpiry = booking.CreatedAt.ToUniversalTime().AddMinutes(5);
            var expiredAtUnix  = (int)new DateTimeOffset(seatLockExpiry).ToUnixTimeSeconds();

            var request = new CreatePaymentLinkRequest
            {
                OrderCode   = (int)booking.OrderCode,
                Amount      = (int)booking.TotalAmount,
                Description = "Movie Tickets",
                ReturnUrl   = _config["PayOS:ReturnUrl"] ?? "https://domain-cua-app.com/success",
                CancelUrl   = _config["PayOS:CancelUrl"] ?? "https://domain-cua-app.com/cancel",
                ExpiredAt   = expiredAtUnix
            };

            var result = await _client.PaymentRequests.CreateAsync(request);
            return result.CheckoutUrl;
        }

        public async Task<bool> HandleWebhook(string webhookBody)
        {
            var orderCode = await GetVerifiedOrderCode(webhookBody);
            return orderCode.HasValue;
        }

        public async Task<long?> GetVerifiedOrderCode(string webhookBody)
        {
            try
            {
                var webhook = System.Text.Json.JsonSerializer.Deserialize<Webhook>(
                    webhookBody,
                    new System.Text.Json.JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                if (webhook == null) return null;

                // VerifyAsync trả về WebhookData trực tiếp (không có wrapper .Data)
                // WebhookData có: Code, OrderCode, Amount, Description, ...
                var webhookData = await _client.Webhooks.VerifyAsync(webhook);

                if (webhookData?.Code == "00")
                    return webhookData.OrderCode;

                return null;
            }
            catch
            {
                return null;
            }
        }
        public async Task<string?> GetPaymentStatus(long orderCode)
        {
            try
            {
                var info = await _client.PaymentRequests.GetAsync(orderCode);
                // PayOS trả về status: "PENDING", "PAID", "CANCELLED", "EXPIRED"
                return info?.Status.ToString().ToUpper();
            }
            catch
            {
                return null;
            }
        }
    }
}
