import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_create_widget/post_bottom_bar.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_create_widget/post_image_preview.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_create_widget/post_text_input.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_create_widget/post_user_info.dart';
// import 'package:provider/provider.dart';
// import '../../providers/post_provider_old.dart';

class CreatePostView extends ConsumerStatefulWidget {
  final bool autoPickImage;

  const CreatePostView({super.key, this.autoPickImage = false});

  @override
  ConsumerState<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends ConsumerState<CreatePostView> {
  final controller = TextEditingController();
  final picker = ImagePicker();

  io.File? imageFile;
  Uint8List? imageBytes;
  int charCount = 0;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() => charCount = controller.text.length);
    });

    if (widget.autoPickImage) {
      Future.microtask(pickImage);
    }
  }

  Future<void> pickImage() async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;

    if (kIsWeb) {
      imageBytes = await img.readAsBytes();
      imageFile = null;
    } else {
      imageFile = io.File(img.path);
      imageBytes = null;
    }

    setState(() {});
  }

  void removeImage() {
    setState(() {
      imageFile = null;
      imageBytes = null;
    });
  }

  void submitPost() async {
  final text = controller.text.trim();

  // ✅ validate
  if (text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Nội dung không được rỗng")),
    );
    return;
  }

  try {
    await ref
        .read(postControllerProvider.notifier)
        .createPost(text); // 👈 gọi API

    if (!mounted) return;

    Navigator.pop(context); // quay lại màn trước

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đăng bài thành công 🚀")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đăng bài thất bại")),
    );
  }
}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text("Tạo bài viết"),
        backgroundColor: const Color(0xFFF8BBD0),
      ),
      body: Column(
        children: [
          const PostUserInfo(),
          Expanded(
            child: Column(
              children: [
                PostTextInput(controller: controller),
                if (imageFile != null || imageBytes != null)
                  PostImagePreview(
                    imageFile: imageFile,
                    imageBytes: imageBytes,
                    onRemove: removeImage,
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: PostBottomBar(
        charCount: charCount,
        onPickImage: pickImage,
        onSubmit: submitPost,
      ),
    );
  }
}
