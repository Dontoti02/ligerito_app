// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pushServiceHash() => r'838149c86977c37ad471aa7e7fbb925d06a22baa';

/// Punto único de swap de notificaciones (misma filosofía Mock→Remote):
/// para FCM, overridear este provider con un FirebasePushService en app.dart.
///
/// Copied from [pushService].
@ProviderFor(pushService)
final pushServiceProvider = Provider<PushService>.internal(
  pushService,
  name: r'pushServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pushServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PushServiceRef = ProviderRef<PushService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
