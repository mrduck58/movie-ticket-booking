import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/cinema_providers.dart';

class CinemaMoviesPage extends ConsumerWidget {
  final String cinemaId;
  final String cinemaName;

  const CinemaMoviesPage({
    super.key,
    required this.cinemaId,
    required this.cinemaName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(moviesByCinemaProvider(cinemaId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          cinemaName, // Hiển thị tên rạp
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/cinemas'),
        ),
      ),
      body: moviesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text("Hiện không có phim nào chiếu tại rạp này."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                color: Colors.white10,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.posterUrl,
                      width: 60, // Kích thước bé lại theo ý bạn
                      height: 90,
                      fit: BoxFit.cover,
                      // Đây là phần xử lý khi ảnh lỗi
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1), // Nền đỏ nhạt
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ), // Viền đỏ
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Lỗi ảnh",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red, // Chữ màu đỏ
                                  fontSize: 8, // Chữ cho bé lại
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${movie.durationMin} min | Rating: ${movie.rating}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // 1. Lấy notifier của booking draft
                    final booking = ref.read(bookingDraftProvider.notifier);

                    // 2. Lấy bộ phim hiện tại (Biến 'movie' này đã là Entity rồi nên KHÔNG dùng .toEntity())
                    booking.setMovie(movie);

                    // 3. Lấy thực thể Cinema từ allCinemasProvider
                    final cinemas = ref.read(allCinemasProvider).value;
                    if (cinemas != null) {
                      try {
                        final currentCinema = cinemas.firstWhere(
                          (c) => c.id == cinemaId,
                        );
                        booking.setCinema(currentCinema);
                      } catch (e) {
                        debugPrint("Không tìm thấy rạp: $e");
                      }
                    }

                    // 4. Chuyển hướng sang trang suất chiếu
                    // Lưu ý: movie.id là tên thuộc tính trong lớp Entity của bạn
                    context.push('/showtimes/${movie.id}/$cinemaId');
                  },
                  // 1. Lấy thông tin phim hiện tại (movie đã có sẵn trong itemBuilder)

                  // 2. Truy cập vào booking notifier
                ),
              );
            },
          );
        },
      ),
    );
  }
}
