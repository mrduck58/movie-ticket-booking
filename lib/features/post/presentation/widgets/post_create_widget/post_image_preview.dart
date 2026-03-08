import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';

class PostImagePreview extends StatelessWidget {
  final io.File? imageFile;
  final Uint8List? imageBytes;
  final VoidCallback onRemove;

  const PostImagePreview({
    super.key,
    this.imageFile,
    this.imageBytes,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: kIsWeb
                ? Image.memory(imageBytes!)
                : Image.file(imageFile!),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}