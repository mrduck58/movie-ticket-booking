import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/showtime_mock_datasource.dart';
import '../../data/models/showtime_model.dart';
import '../../data/repositories/showtime_repository.dart';

final showtimeDataSourceProvider = Provider((ref) => ShowtimeMockDataSource());

final showtimeRepositoryProvider = Provider<ShowtimeRepository>((ref) {
  return ShowtimeRepositoryImpl(ref.watch(showtimeDataSourceProvider));
});

final allShowtimesProvider = FutureProvider<List<ShowtimeModel>>((ref) async {
  return ref.watch(showtimeRepositoryProvider).getShowtimes();
});

class SelectedDateIndex extends Notifier<int> {
  @override
  int build() => 0;
  void set(int value) => state = value;
}
final selectedDateIndexProvider =
    NotifierProvider<SelectedDateIndex, int>(SelectedDateIndex.new);

/// key = "${format}|${time}" 
class SelectedTimeKey extends Notifier<String?> {
  @override
  String? build() => null;
  void select(String key) => state = key;
  void clear() => state = null;
}
final selectedTimeKeyProvider =
    NotifierProvider<SelectedTimeKey, String?>(SelectedTimeKey.new);