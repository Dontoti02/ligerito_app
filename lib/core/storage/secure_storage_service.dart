// lib/core/storage/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ligerito/core/constants/app_strings.dart';

/// Tokens JWT SOLO aquí (criterio 8.1). Nunca en shared_preferences.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> leerToken() => _storage.read(key: AppStrings.keyTokenSesion);

  Future<String?> leerRefreshToken() =>
      _storage.read(key: AppStrings.keyRefreshToken);

  Future<void> guardarTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: AppStrings.keyTokenSesion, value: accessToken);
    await _storage.write(key: AppStrings.keyRefreshToken, value: refreshToken);
  }

  Future<void> limpiar() => _storage.deleteAll();
}
