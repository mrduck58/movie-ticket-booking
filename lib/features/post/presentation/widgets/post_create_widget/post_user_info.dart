import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_controller.dart';
// import '../providers/post_user_provider.dart'; // import provider user

class PostUserInfo extends ConsumerWidget {
  const PostUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        final name = user?['FullName'] ?? 'ĐV';
        final avatar = user?['AvatarUrl']; // URL avatar hoặc null
        final initials = name.isNotEmpty
            ? name.split(' ').map((e) => e[0]).take(2).join()
            : 'ĐV';

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.pink,
                backgroundImage: avatar != null && avatar.isNotEmpty
                    ? NetworkImage(avatar)
                    : null,
                child: avatar == null || avatar.isEmpty
                    ? Text(initials, style: const TextStyle(color: Colors.white))
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
      error: (_, __) => const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Lỗi khi load user'),
      ),
    );
  }
}