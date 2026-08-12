// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$catalogoRepositoryHash() =>
    r'ba6dd8c650fde96bcbeafe314c6b7d176f0375b3';

/// See also [catalogoRepository].
@ProviderFor(catalogoRepository)
final catalogoRepositoryProvider = Provider<CatalogoRepository>.internal(
  catalogoRepository,
  name: r'catalogoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$catalogoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CatalogoRepositoryRef = ProviderRef<CatalogoRepository>;
String _$negociosHash() => r'8375ff869274b73d088d7e50c1172dad20f435e8';

/// See also [negocios].
@ProviderFor(negocios)
final negociosProvider = AutoDisposeFutureProvider<List<Negocio>>.internal(
  negocios,
  name: r'negociosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$negociosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NegociosRef = AutoDisposeFutureProviderRef<List<Negocio>>;
String _$negocioHash() => r'1d320ae842dcea8dd6db8c24683f014ad1593f89';

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

/// See also [negocio].
@ProviderFor(negocio)
const negocioProvider = NegocioFamily();

/// See also [negocio].
class NegocioFamily extends Family<AsyncValue<Negocio?>> {
  /// See also [negocio].
  const NegocioFamily();

  /// See also [negocio].
  NegocioProvider call(String id) {
    return NegocioProvider(id);
  }

  @override
  NegocioProvider getProviderOverride(covariant NegocioProvider provider) {
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
  String? get name => r'negocioProvider';
}

/// See also [negocio].
class NegocioProvider extends AutoDisposeFutureProvider<Negocio?> {
  /// See also [negocio].
  NegocioProvider(String id)
    : this._internal(
        (ref) => negocio(ref as NegocioRef, id),
        from: negocioProvider,
        name: r'negocioProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$negocioHash,
        dependencies: NegocioFamily._dependencies,
        allTransitiveDependencies: NegocioFamily._allTransitiveDependencies,
        id: id,
      );

  NegocioProvider._internal(
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
    FutureOr<Negocio?> Function(NegocioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NegocioProvider._internal(
        (ref) => create(ref as NegocioRef),
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
  AutoDisposeFutureProviderElement<Negocio?> createElement() {
    return _NegocioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NegocioProvider && other.id == id;
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
mixin NegocioRef on AutoDisposeFutureProviderRef<Negocio?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _NegocioProviderElement extends AutoDisposeFutureProviderElement<Negocio?>
    with NegocioRef {
  _NegocioProviderElement(super.provider);

  @override
  String get id => (origin as NegocioProvider).id;
}

String _$productosNegocioHash() => r'73155c9177b0a6ac41a215255dede47d1a8a79fc';

/// See also [productosNegocio].
@ProviderFor(productosNegocio)
const productosNegocioProvider = ProductosNegocioFamily();

/// See also [productosNegocio].
class ProductosNegocioFamily extends Family<AsyncValue<List<Producto>>> {
  /// See also [productosNegocio].
  const ProductosNegocioFamily();

  /// See also [productosNegocio].
  ProductosNegocioProvider call(String negocioId) {
    return ProductosNegocioProvider(negocioId);
  }

  @override
  ProductosNegocioProvider getProviderOverride(
    covariant ProductosNegocioProvider provider,
  ) {
    return call(provider.negocioId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productosNegocioProvider';
}

/// See also [productosNegocio].
class ProductosNegocioProvider
    extends AutoDisposeFutureProvider<List<Producto>> {
  /// See also [productosNegocio].
  ProductosNegocioProvider(String negocioId)
    : this._internal(
        (ref) => productosNegocio(ref as ProductosNegocioRef, negocioId),
        from: productosNegocioProvider,
        name: r'productosNegocioProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productosNegocioHash,
        dependencies: ProductosNegocioFamily._dependencies,
        allTransitiveDependencies:
            ProductosNegocioFamily._allTransitiveDependencies,
        negocioId: negocioId,
      );

  ProductosNegocioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.negocioId,
  }) : super.internal();

  final String negocioId;

  @override
  Override overrideWith(
    FutureOr<List<Producto>> Function(ProductosNegocioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductosNegocioProvider._internal(
        (ref) => create(ref as ProductosNegocioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        negocioId: negocioId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Producto>> createElement() {
    return _ProductosNegocioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductosNegocioProvider && other.negocioId == negocioId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, negocioId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductosNegocioRef on AutoDisposeFutureProviderRef<List<Producto>> {
  /// The parameter `negocioId` of this provider.
  String get negocioId;
}

class _ProductosNegocioProviderElement
    extends AutoDisposeFutureProviderElement<List<Producto>>
    with ProductosNegocioRef {
  _ProductosNegocioProviderElement(super.provider);

  @override
  String get negocioId => (origin as ProductosNegocioProvider).negocioId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
