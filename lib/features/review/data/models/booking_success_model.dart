class BookingSuccessResponse {
  final String bookingId;
  final String showtimeId;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final List<TicketModel> tickets;

  BookingSuccessResponse({
    required this.bookingId,
    required this.showtimeId,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.tickets,
  });

  factory BookingSuccessResponse.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('[DEBUG] Mapping JSON: ${json.keys.toList()}');
    
    final seatsList = (json['bookingSeats'] ?? json['BookingSeats'] ?? json['seats'] ?? json['Seats'] ?? []) as List;

    return BookingSuccessResponse(
      bookingId: (json['bookingId'] ?? json['BookingId'] ?? '').toString(),
      showtimeId: (json['showtimeId'] ?? json['ShowtimeId'] ?? '').toString(),
      totalAmount: (json['totalAmount'] ?? json['TotalAmount'] as num?)?.toDouble() ?? 0,
      status: (json['status'] ?? json['Status'] ?? '').toString(),
      createdAt: json['createdAt'] != null 
        ? DateTime.parse(json['createdAt'])
        : (json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : DateTime.now()),
      tickets: seatsList
        .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
  }
}

class TicketModel {
  final String seatId;
  final String seatName;
  final String qrCode;
  final String status;

  TicketModel({
    required this.seatId,
    required this.seatName,
    required this.qrCode,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print('[DEBUG] Seat JSON: $json');

    final rawQr = json['qrCode'] ?? json['QrCode'] ?? json['qrcode'] ?? json['qrDatas'];
    String code = '';
    if (rawQr is List && rawQr.isNotEmpty) {
      code = rawQr.first.toString();
    } else if (rawQr != null) {
      code = rawQr.toString();
    }

    return TicketModel(
      seatId: (json['seatId'] ?? json['SeatId'] ?? '').toString(),
      seatName: (json['seatName'] ?? json['SeatName'] ?? '').toString(),
      qrCode: code,
      status: (json['status'] ?? json['Status'] ?? '').toString(),
    );
  }
}
