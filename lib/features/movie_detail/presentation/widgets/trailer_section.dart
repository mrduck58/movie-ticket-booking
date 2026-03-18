import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerSection extends StatelessWidget {
  final dynamic movie;

  const TrailerSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Trailer",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () async {
            final url = Uri.parse(movie.trailer);
            if (await canLaunchUrl(url)) {
              launchUrl(url);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.posterUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Icon(Icons.play_arrow, color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}