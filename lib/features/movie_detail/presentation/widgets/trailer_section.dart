import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerSection extends StatelessWidget {
  final dynamic movie;

  const TrailerSection({super.key, required this.movie});

  /// ✅ Lấy thumbnail YouTube (support cả 2 dạng link)
  String getYoutubeThumbnail(String url) {
    final uri = Uri.parse(url);

    String? videoId;

    // dạng: youtube.com/watch?v=xxx
    if (uri.queryParameters.containsKey('v')) {
      videoId = uri.queryParameters['v'];
    }
    // dạng: youtu.be/xxx
    else if (uri.host.contains("youtu.be")) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    // fallback nếu lỗi
    videoId ??= "";

    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  /// ✅ mở trailer (fix cho Web + Mobile)
  Future<void> openTrailer(String url) async {
    final uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      debugPrint("❌ Cannot launch: $url");
      return;
    }

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final trailerUrl = movie.trailerUrl;

    /// ❌ nếu không có trailer thì không hiển thị
    if (trailerUrl == null || trailerUrl.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trailer",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => openTrailer(trailerUrl),

          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  getYoutubeThumbnail(trailerUrl),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  /// fallback nếu ảnh lỗi
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    );
                  },
                ),
              ),

              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Icon(Icons.play_arrow, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
