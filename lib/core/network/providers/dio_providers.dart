import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/network/dio_client.dart';
import 'package:ligerito/core/storage/secure_storage_service.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_providers.g.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return buildDioClient(
    storage,
    onSesionExpirada: () async {
      ref.read(sesionControllerProvider.notifier).cerrarSesion();
    },
  );
}
