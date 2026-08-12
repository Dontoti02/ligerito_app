// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerRefreshHash() => r'67b40295469796a7347feeac97afa5abd6a194cf';

/// Re-notifica al router cuando cambia la sesión (para re-evaluar redirects).
///
/// Copied from [routerRefresh].
@ProviderFor(routerRefresh)
final routerRefreshProvider = Provider<ChangeNotifier>.internal(
  routerRefresh,
  name: r'routerRefreshProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerRefreshHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRefreshRef = ProviderRef<ChangeNotifier>;
String _$appRouterHash() => r'ab2cddc74fa70ce1ecaf6ec72e00fdf1370c1de5';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
