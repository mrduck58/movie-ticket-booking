class BookingExpiryState {
  final DateTime? startedAt;
  final DateTime? expiresAt;
  final Duration remaining;
  final bool isRunning;
  final bool isExpired;

  const BookingExpiryState({
    this.startedAt,
    this.expiresAt,
    this.remaining = Duration.zero,
    this.isRunning = false,
    this.isExpired = false,
  });

  BookingExpiryState copyWith({
    DateTime? startedAt,
    DateTime? expiresAt,
    Duration? remaining,
    bool? isRunning,
    bool? isExpired,
  }) {
    return BookingExpiryState(
      startedAt: startedAt ?? this.startedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      remaining: remaining ?? this.remaining,
      isRunning: isRunning ?? this.isRunning,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  factory BookingExpiryState.initial() => const BookingExpiryState();
}