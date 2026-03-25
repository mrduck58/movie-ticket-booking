import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerPlayerPage extends StatefulWidget {
  final String trailerUrl;

  const TrailerPlayerPage({super.key, required this.trailerUrl});

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {
  YoutubePlayerController? controller;
  String? videoId;

  @override
  void initState() {
    super.initState();

    /// 🔥 B1: lấy videoId từ URL
    videoId = YoutubePlayerController.convertUrlToId(widget.trailerUrl);

    /// 🔥 B2: fallback nếu convert fail
    if (videoId == null || videoId!.isEmpty) {
      final uri = Uri.parse(widget.trailerUrl);

      // dạng youtube.com/watch?v=xxx
      if (uri.queryParameters.containsKey('v')) {
        videoId = uri.queryParameters['v'];
      }
      // dạng youtu.be/xxx
      else if (uri.host.contains("youtu.be")) {
        videoId =
            uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }
    }

    /// 🔥 B3: tạo controller nếu hợp lệ
    if (videoId != null && videoId!.isNotEmpty) {
      controller = YoutubePlayerController.fromVideoId(
        videoId: videoId!,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableJavaScript: true,
        ),
      );
    } else {
      debugPrint("❌ Invalid YouTube URL: ${widget.trailerUrl}");
    }
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Trailer"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: videoId == null || videoId!.isEmpty
            ? const Text(
                "Invalid trailer URL",
                style: TextStyle(color: Colors.white),
              )
            : AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: controller!,
                ),
              ),
      ),
    );
  }
}