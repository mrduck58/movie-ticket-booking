import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

final priceProvider = Provider<int>((ref) {

  final draft = ref.watch(bookingDraftProvider);

  if (draft == null) return 0;

  return draft.seats.length * 50000;
});