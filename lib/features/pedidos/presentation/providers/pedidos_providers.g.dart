// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedidos_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pedidosRepositoryHash() => r'4fd179d8a3e13e30789288009ee63104ced42ac5';

/// See also [pedidosRepository].
@ProviderFor(pedidosRepository)
final pedidosRepositoryProvider = Provider<PedidosRepository>.internal(
  pedidosRepository,
  name: r'pedidosRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pedidosRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PedidosRepositoryRef = ProviderRef<PedidosRepository>;
String _$misPedidosHash() => r'c5580f0c560dac7ac52dbf73c26a30be782088c6';

/// See also [misPedidos].
@ProviderFor(misPedidos)
final misPedidosProvider = AutoDisposeFutureProvider<List<Pedido>>.internal(
  misPedidos,
  name: r'misPedidosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$misPedidosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MisPedidosRef = AutoDisposeFutureProviderRef<List<Pedido>>;
String _$pedidoDetalleHash() => r'2ba6450bcd7ab6d1b4eeefd82bdf0431316c8a15';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [pedidoDetalle].
@ProviderFor(pedidoDetalle)
const pedidoDetalleProvider = PedidoDetalleFamily();

/// See also [pedidoDetalle].
class PedidoDetalleFamily extends Family<AsyncValue<Pedido?>> {
  /// See also [pedidoDetalle].
  const PedidoDetalleFamily();

  /// See also [pedidoDetalle].
  PedidoDetalleProvider call(String id) {
    return PedidoDetalleProvider(id);
  }

  @override
  PedidoDetalleProvider getProviderOverride(
    covariant PedidoDetalleProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pedidoDetalleProvider';
}

/// See also [pedidoDetalle].
class PedidoDetalleProvider extends AutoDisposeFutureProvider<Pedido?> {
  /// See also [pedidoDetalle].
  PedidoDetalleProvider(String id)
    : this._internal(
        (ref) => pedidoDetalle(ref as PedidoDetalleRef, id),
        from: pedidoDetalleProvider,
        name: r'pedidoDetalleProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$pedidoDetalleHash,
        dependencies: PedidoDetalleFamily._dependencies,
        allTransitiveDependencies:
            PedidoDetalleFamily._allTransitiveDependencies,
        id: id,
      );

  PedidoDetalleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Pedido?> Function(PedidoDetalleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PedidoDetalleProvider._internal(
        (ref) => create(ref as PedidoDetalleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Pedido?> createElement() {
    return _PedidoDetalleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PedidoDetalleProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PedidoDetalleRef on AutoDisposeFutureProviderRef<Pedido?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PedidoDetalleProviderElement
    extends AutoDisposeFutureProviderElement<Pedido?>
    with PedidoDetalleRef {
  _PedidoDetalleProviderElement(super.provider);

  @override
  String get id => (origin as PedidoDetalleProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
