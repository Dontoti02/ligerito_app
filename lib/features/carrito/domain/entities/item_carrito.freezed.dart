// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_carrito.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ItemCarrito {
  Producto get producto => throw _privateConstructorUsedError;
  int get cantidad => throw _privateConstructorUsedError;
  String? get notas => throw _privateConstructorUsedError;

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCarritoCopyWith<ItemCarrito> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCarritoCopyWith<$Res> {
  factory $ItemCarritoCopyWith(
    ItemCarrito value,
    $Res Function(ItemCarrito) then,
  ) = _$ItemCarritoCopyWithImpl<$Res, ItemCarrito>;
  @useResult
  $Res call({Producto producto, int cantidad, String? notas});

  $ProductoCopyWith<$Res> get producto;
}

/// @nodoc
class _$ItemCarritoCopyWithImpl<$Res, $Val extends ItemCarrito>
    implements $ItemCarritoCopyWith<$Res> {
  _$ItemCarritoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? producto = null,
    Object? cantidad = null,
    Object? notas = freezed,
  }) {
    return _then(
      _value.copyWith(
            producto: null == producto
                ? _value.producto
                : producto // ignore: cast_nullable_to_non_nullable
                      as Producto,
            cantidad: null == cantidad
                ? _value.cantidad
                : cantidad // ignore: cast_nullable_to_non_nullable
                      as int,
            notas: freezed == notas
                ? _value.notas
                : notas // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductoCopyWith<$Res> get producto {
    return $ProductoCopyWith<$Res>(_value.producto, (value) {
      return _then(_value.copyWith(producto: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemCarritoImplCopyWith<$Res>
    implements $ItemCarritoCopyWith<$Res> {
  factory _$$ItemCarritoImplCopyWith(
    _$ItemCarritoImpl value,
    $Res Function(_$ItemCarritoImpl) then,
  ) = __$$ItemCarritoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Producto producto, int cantidad, String? notas});

  @override
  $ProductoCopyWith<$Res> get producto;
}

/// @nodoc
class __$$ItemCarritoImplCopyWithImpl<$Res>
    extends _$ItemCarritoCopyWithImpl<$Res, _$ItemCarritoImpl>
    implements _$$ItemCarritoImplCopyWith<$Res> {
  __$$ItemCarritoImplCopyWithImpl(
    _$ItemCarritoImpl _value,
    $Res Function(_$ItemCarritoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? producto = null,
    Object? cantidad = null,
    Object? notas = freezed,
  }) {
    return _then(
      _$ItemCarritoImpl(
        producto: null == producto
            ? _value.producto
            : producto // ignore: cast_nullable_to_non_nullable
                  as Producto,
        cantidad: null == cantidad
            ? _value.cantidad
            : cantidad // ignore: cast_nullable_to_non_nullable
                  as int,
        notas: freezed == notas
            ? _value.notas
            : notas // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ItemCarritoImpl extends _ItemCarrito {
  const _$ItemCarritoImpl({
    required this.producto,
    required this.cantidad,
    this.notas,
  }) : super._();

  @override
  final Producto producto;
  @override
  final int cantidad;
  @override
  final String? notas;

  @override
  String toString() {
    return 'ItemCarrito(producto: $producto, cantidad: $cantidad, notas: $notas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemCarritoImpl &&
            (identical(other.producto, producto) ||
                other.producto == producto) &&
            (identical(other.cantidad, cantidad) ||
                other.cantidad == cantidad) &&
            (identical(other.notas, notas) || other.notas == notas));
  }

  @override
  int get hashCode => Object.hash(runtimeType, producto, cantidad, notas);

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemCarritoImplCopyWith<_$ItemCarritoImpl> get copyWith =>
      __$$ItemCarritoImplCopyWithImpl<_$ItemCarritoImpl>(this, _$identity);
}

abstract class _ItemCarrito extends ItemCarrito {
  const factory _ItemCarrito({
    required final Producto producto,
    required final int cantidad,
    final String? notas,
  }) = _$ItemCarritoImpl;
  const _ItemCarrito._() : super._();

  @override
  Producto get producto;
  @override
  int get cantidad;
  @override
  String? get notas;

  /// Create a copy of ItemCarrito
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemCarritoImplCopyWith<_$ItemCarritoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
