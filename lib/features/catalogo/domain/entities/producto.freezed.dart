// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'producto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Producto {
  String get id => throw _privateConstructorUsedError;
  String get negocioId => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String? get descripcion => throw _privateConstructorUsedError;
  int get precioEnCentavos => throw _privateConstructorUsedError;
  String? get imagenUrl => throw _privateConstructorUsedError;
  bool get disponible => throw _privateConstructorUsedError;
  String? get seccionMenu => throw _privateConstructorUsedError;

  /// Create a copy of Producto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductoCopyWith<Producto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductoCopyWith<$Res> {
  factory $ProductoCopyWith(Producto value, $Res Function(Producto) then) =
      _$ProductoCopyWithImpl<$Res, Producto>;
  @useResult
  $Res call({
    String id,
    String negocioId,
    String nombre,
    String? descripcion,
    int precioEnCentavos,
    String? imagenUrl,
    bool disponible,
    String? seccionMenu,
  });
}

/// @nodoc
class _$ProductoCopyWithImpl<$Res, $Val extends Producto>
    implements $ProductoCopyWith<$Res> {
  _$ProductoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Producto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? negocioId = null,
    Object? nombre = null,
    Object? descripcion = freezed,
    Object? precioEnCentavos = null,
    Object? imagenUrl = freezed,
    Object? disponible = null,
    Object? seccionMenu = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            negocioId: null == negocioId
                ? _value.negocioId
                : negocioId // ignore: cast_nullable_to_non_nullable
                      as String,
            nombre: null == nombre
                ? _value.nombre
                : nombre // ignore: cast_nullable_to_non_nullable
                      as String,
            descripcion: freezed == descripcion
                ? _value.descripcion
                : descripcion // ignore: cast_nullable_to_non_nullable
                      as String?,
            precioEnCentavos: null == precioEnCentavos
                ? _value.precioEnCentavos
                : precioEnCentavos // ignore: cast_nullable_to_non_nullable
                      as int,
            imagenUrl: freezed == imagenUrl
                ? _value.imagenUrl
                : imagenUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            disponible: null == disponible
                ? _value.disponible
                : disponible // ignore: cast_nullable_to_non_nullable
                      as bool,
            seccionMenu: freezed == seccionMenu
                ? _value.seccionMenu
                : seccionMenu // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductoImplCopyWith<$Res>
    implements $ProductoCopyWith<$Res> {
  factory _$$ProductoImplCopyWith(
    _$ProductoImpl value,
    $Res Function(_$ProductoImpl) then,
  ) = __$$ProductoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String negocioId,
    String nombre,
    String? descripcion,
    int precioEnCentavos,
    String? imagenUrl,
    bool disponible,
    String? seccionMenu,
  });
}

/// @nodoc
class __$$ProductoImplCopyWithImpl<$Res>
    extends _$ProductoCopyWithImpl<$Res, _$ProductoImpl>
    implements _$$ProductoImplCopyWith<$Res> {
  __$$ProductoImplCopyWithImpl(
    _$ProductoImpl _value,
    $Res Function(_$ProductoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Producto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? negocioId = null,
    Object? nombre = null,
    Object? descripcion = freezed,
    Object? precioEnCentavos = null,
    Object? imagenUrl = freezed,
    Object? disponible = null,
    Object? seccionMenu = freezed,
  }) {
    return _then(
      _$ProductoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        negocioId: null == negocioId
            ? _value.negocioId
            : negocioId // ignore: cast_nullable_to_non_nullable
                  as String,
        nombre: null == nombre
            ? _value.nombre
            : nombre // ignore: cast_nullable_to_non_nullable
                  as String,
        descripcion: freezed == descripcion
            ? _value.descripcion
            : descripcion // ignore: cast_nullable_to_non_nullable
                  as String?,
        precioEnCentavos: null == precioEnCentavos
            ? _value.precioEnCentavos
            : precioEnCentavos // ignore: cast_nullable_to_non_nullable
                  as int,
        imagenUrl: freezed == imagenUrl
            ? _value.imagenUrl
            : imagenUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        disponible: null == disponible
            ? _value.disponible
            : disponible // ignore: cast_nullable_to_non_nullable
                  as bool,
        seccionMenu: freezed == seccionMenu
            ? _value.seccionMenu
            : seccionMenu // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ProductoImpl implements _Producto {
  const _$ProductoImpl({
    required this.id,
    required this.negocioId,
    required this.nombre,
    this.descripcion,
    required this.precioEnCentavos,
    this.imagenUrl,
    required this.disponible,
    this.seccionMenu,
  });

  @override
  final String id;
  @override
  final String negocioId;
  @override
  final String nombre;
  @override
  final String? descripcion;
  @override
  final int precioEnCentavos;
  @override
  final String? imagenUrl;
  @override
  final bool disponible;
  @override
  final String? seccionMenu;

  @override
  String toString() {
    return 'Producto(id: $id, negocioId: $negocioId, nombre: $nombre, descripcion: $descripcion, precioEnCentavos: $precioEnCentavos, imagenUrl: $imagenUrl, disponible: $disponible, seccionMenu: $seccionMenu)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.negocioId, negocioId) ||
                other.negocioId == negocioId) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion) &&
            (identical(other.precioEnCentavos, precioEnCentavos) ||
                other.precioEnCentavos == precioEnCentavos) &&
            (identical(other.imagenUrl, imagenUrl) ||
                other.imagenUrl == imagenUrl) &&
            (identical(other.disponible, disponible) ||
                other.disponible == disponible) &&
            (identical(other.seccionMenu, seccionMenu) ||
                other.seccionMenu == seccionMenu));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    negocioId,
    nombre,
    descripcion,
    precioEnCentavos,
    imagenUrl,
    disponible,
    seccionMenu,
  );

  /// Create a copy of Producto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductoImplCopyWith<_$ProductoImpl> get copyWith =>
      __$$ProductoImplCopyWithImpl<_$ProductoImpl>(this, _$identity);
}

abstract class _Producto implements Producto {
  const factory _Producto({
    required final String id,
    required final String negocioId,
    required final String nombre,
    final String? descripcion,
    required final int precioEnCentavos,
    final String? imagenUrl,
    required final bool disponible,
    final String? seccionMenu,
  }) = _$ProductoImpl;

  @override
  String get id;
  @override
  String get negocioId;
  @override
  String get nombre;
  @override
  String? get descripcion;
  @override
  int get precioEnCentavos;
  @override
  String? get imagenUrl;
  @override
  bool get disponible;
  @override
  String? get seccionMenu;

  /// Create a copy of Producto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductoImplCopyWith<_$ProductoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
