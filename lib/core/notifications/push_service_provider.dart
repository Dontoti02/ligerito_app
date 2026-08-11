// lib/core/notifications/push_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/notifications/local_push_service.dart';
import 'package:ligerito/core/notifications/push_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_service_provider.g.dart';

/// Punto único de swap de notificaciones (misma filosofía Mock→Remote):
/// para FCM, overridear este provider con un FirebasePushService en app.dart.
@Riverpod(keepAlive: true)
PushService pushService(Ref ref) => LocalPushService();
