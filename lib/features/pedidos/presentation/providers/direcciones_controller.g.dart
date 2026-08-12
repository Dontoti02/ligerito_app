// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direcciones_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$direccionesRepositoryHash() =>
    r'b211850d09201a20dc23e995b09052d8a8410b8f';

/// See also [direccionesRepository].
@ProviderFor(direccionesRepository)
final direccionesRepositoryProvider = Provider<DireccionesRepository>.internal(
  direccionesRepository,
  name: r'direccionesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$direccionesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DireccionesRepositoryRef = ProviderRef<DireccionesRepository>;
String _$direccionesControllerHash() =>
    r'd47f7426bdb7dd15b1c455447b60581e13ba3936';

/// See also [DireccionesController].
@ProviderFor(DireccionesController)
final direccionesControllerProvider =
    AsyncNotifierProvider<DireccionesController, DireccionesState>.internal(
      DireccionesController.new,
      name: r'direccionesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$direccionesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DireccionesController = AsyncNotifier<DireccionesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
