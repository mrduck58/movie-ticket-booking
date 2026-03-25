import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_controller.dart';
import 'notification_state.dart';

final notificationHttpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
  return NotificationRemoteDataSource(
    ref.read(notificationHttpClientProvider),
  );
});

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    ref.read(notificationRemoteDataSourceProvider),
  );
});

final notificationControllerProvider =
    AsyncNotifierProvider<NotificationController, List<NotificationSection>>(
  NotificationController.new,
);