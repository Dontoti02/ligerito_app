// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'27d8d5c44ce8b0ce8f6824392cff06b2173d7ab4';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$sesionControllerHash() => r'935278a86c0d8454a494aa66ee537b7eb2775952';

/// See also [SesionController].
@ProviderFor(SesionController)
final sesionControllerProvider =
    AsyncNotifierProvider<SesionController, SesionState>.internal(
      SesionController.new,
      name: r'sesionControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sesionControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SesionController = AsyncNotifier<SesionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
