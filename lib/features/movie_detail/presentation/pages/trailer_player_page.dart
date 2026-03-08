import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerPlayerPage extends StatefulWidget {
  final String trailerUrl;

  const TrailerPlayerPage({super.key, required this.trailerUrl});

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    final videoId =
        YoutubePlayerController.convertUrlToId(widget.trailerUrl) ?? "";

    controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
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
        child: YoutubePlayer(
          controller: controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}