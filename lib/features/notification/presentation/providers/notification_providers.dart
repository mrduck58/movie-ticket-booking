import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/notification_local_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_controller.dart';
import 'notification_state.dart';

final notificationLocalDataSourceProvider =
    Provider((ref) => NotificationLocalDataSource());

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    ref.read(notificationLocalDataSourceProvider),
  );
});

final notificationControllerProvider =
    AsyncNotifierProvider<
        NotificationController,
        List<NotificationSection>>(
  NotificationController.new,
);