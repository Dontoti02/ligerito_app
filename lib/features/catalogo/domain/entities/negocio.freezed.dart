// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'negocio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Negocio {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get categoria => throw _privateConstructorUsedError;
  String get logoUrl => throw _privateConstructorUsedError;
  double get calificacion => throw _privateConstructorUsedError;
  bool get abierto => throw _privateConstructorUsedError;
  int get tiempoEstimadoMin => throw _privateConstructorUsedError;
  double get costoEnvioBase => throw _privateConstructorUsedError;
  double get pedidoMinimo => throw _privateConstructorUsedError;
  Direccion get direccion => throw _privateConstructorUsedError;

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NegocioCopyWith<Negocio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NegocioCopyWith<$Res> {
  factory $NegocioCopyWith(Negocio value, $Res Function(Negocio) then) =
      _$NegocioCopyWithImpl<$Res, Negocio>;
  @useResult
  $Res call({
    String id,
    String nombre,
    String categoria,
    String logoUrl,
    double calificacion,
    bool abierto,
    int tiempoEstimadoMin,
    double costoEnvioBase,
    double pedidoMinimo,
    Direccion direccion,
  });

  $DireccionCopyWith<$Res> get direccion;
}

/// @nodoc
class _$NegocioCopyWithImpl<$Res, $Val extends Negocio>
    implements $NegocioCopyWith<$Res> {
  _$NegocioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? categoria = null,
    Object? logoUrl = null,
    Object? calificacion = null,
    Object? abierto = null,
    Object? tiempoEstimadoMin = null,
    Object? costoEnvioBase = null,
    Object? pedidoMinimo = null,
    Object? direccion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nombre: null == nombre
                ? _value.nombre
                : nombre // ignore: cast_nullable_to_non_nullable
                      as String,
            categoria: null == categoria
                ? _value.categoria
                : categoria // ignore: cast_nullable_to_non_nullable
                      as String,
            logoUrl: null == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            calificacion: null == calificacion
                ? _value.calificacion
                : calificacion // ignore: cast_nullable_to_non_nullable
                      as double,
            abierto: null == abierto
                ? _value.abierto
                : abierto // ignore: cast_nullable_to_non_nullable
                      as bool,
            tiempoEstimadoMin: null == tiempoEstimadoMin
                ? _value.tiempoEstimadoMin
                : tiempoEstimadoMin // ignore: cast_nullable_to_non_nullable
                      as int,
            costoEnvioBase: null == costoEnvioBase
                ? _value.costoEnvioBase
                : costoEnvioBase // ignore: cast_nullable_to_non_nullable
                      as double,
            pedidoMinimo: null == pedidoMinimo
                ? _value.pedidoMinimo
                : pedidoMinimo // ignore: cast_nullable_to_non_nullable
                      as double,
            direccion: null == direccion
                ? _value.direccion
                : direccion // ignore: cast_nullable_to_non_nullable
                      as Direccion,
          )
          as $Val,
    );
  }

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DireccionCopyWith<$Res> get direccion {
    return $DireccionCopyWith<$Res>(_value.direccion, (value) {
      return _then(_value.copyWith(direccion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NegocioImplCopyWith<$Res> implements $NegocioCopyWith<$Res> {
  factory _$$NegocioImplCopyWith(
    _$NegocioImpl value,
    $Res Function(_$NegocioImpl) then,
  ) = __$$NegocioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nombre,
    String categoria,
    String logoUrl,
    double calificacion,
    bool abierto,
    int tiempoEstimadoMin,
    double costoEnvioBase,
    double pedidoMinimo,
    Direccion direccion,
  });

  @override
  $DireccionCopyWith<$Res> get direccion;
}

/// @nodoc
class __$$NegocioImplCopyWithImpl<$Res>
    extends _$NegocioCopyWithImpl<$Res, _$NegocioImpl>
    implements _$$NegocioImplCopyWith<$Res> {
  __$$NegocioImplCopyWithImpl(
    _$NegocioImpl _value,
    $Res Function(_$NegocioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? categoria = null,
    Object? logoUrl = null,
    Object? calificacion = null,
    Object? abierto = null,
    Object? tiempoEstimadoMin = null,
    Object? costoEnvioBase = null,
    Object? pedidoMinimo = null,
    Object? direccion = null,
  }) {
    return _then(
      _$NegocioImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nombre: null == nombre
            ? _value.nombre
            : nombre // ignore: cast_nullable_to_non_nullable
                  as String,
        categoria: null == categoria
            ? _value.categoria
            : categoria // ignore: cast_nullable_to_non_nullable
                  as String,
        logoUrl: null == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        calificacion: null == calificacion
            ? _value.calificacion
            : calificacion // ignore: cast_nullable_to_non_nullable
                  as double,
        abierto: null == abierto
            ? _value.abierto
            : abierto // ignore: cast_nullable_to_non_nullable
                  as bool,
        tiempoEstimadoMin: null == tiempoEstimadoMin
            ? _value.tiempoEstimadoMin
            : tiempoEstimadoMin // ignore: cast_nullable_to_non_nullable
                  as int,
        costoEnvioBase: null == costoEnvioBase
            ? _value.costoEnvioBase
            : costoEnvioBase // ignore: cast_nullable_to_non_nullable
                  as double,
        pedidoMinimo: null == pedidoMinimo
            ? _value.pedidoMinimo
            : pedidoMinimo // ignore: cast_nullable_to_non_nullable
                  as double,
        direccion: null == direccion
            ? _value.direccion
            : direccion // ignore: cast_nullable_to_non_nullable
                  as Direccion,
      ),
    );
  }
}

/// @nodoc

class _$NegocioImpl implements _Negocio {
  const _$NegocioImpl({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.logoUrl,
    required this.calificacion,
    required this.abierto,
    required this.tiempoEstimadoMin,
    required this.costoEnvioBase,
    required this.pedidoMinimo,
    required this.direccion,
  });

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String categoria;
  @override
  final String logoUrl;
  @override
  final double calificacion;
  @override
  final bool abierto;
  @override
  final int tiempoEstimadoMin;
  @override
  final double costoEnvioBase;
  @override
  final double pedidoMinimo;
  @override
  final Direccion direccion;

  @override
  String toString() {
    return 'Negocio(id: $id, nombre: $nombre, categoria: $categoria, logoUrl: $logoUrl, calificacion: $calificacion, abierto: $abierto, tiempoEstimadoMin: $tiempoEstimadoMin, costoEnvioBase: $costoEnvioBase, pedidoMinimo: $pedidoMinimo, direccion: $direccion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NegocioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.categoria, categoria) ||
                other.categoria == categoria) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.calificacion, calificacion) ||
                other.calificacion == calificacion) &&
            (identical(other.abierto, abierto) || other.abierto == abierto) &&
            (identical(other.tiempoEstimadoMin, tiempoEstimadoMin) ||
                other.tiempoEstimadoMin == tiempoEstimadoMin) &&
            (identical(other.costoEnvioBase, costoEnvioBase) ||
                other.costoEnvioBase == costoEnvioBase) &&
            (identical(other.pedidoMinimo, pedidoMinimo) ||
                other.pedidoMinimo == pedidoMinimo) &&
            (identical(other.direccion, direccion) ||
                other.direccion == direccion));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nombre,
    categoria,
    logoUrl,
    calificacion,
    abierto,
    tiempoEstimadoMin,
    costoEnvioBase,
    pedidoMinimo,
    direccion,
  );

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NegocioImplCopyWith<_$NegocioImpl> get copyWith =>
      __$$NegocioImplCopyWithImpl<_$NegocioImpl>(this, _$identity);
}

abstract class _Negocio implements Negocio {
  const factory _Negocio({
    required final String id,
    required final String nombre,
    required final String categoria,
    required final String logoUrl,
    required final double calificacion,
    required final bool abierto,
    required final int tiempoEstimadoMin,
    required final double costoEnvioBase,
    required final double pedidoMinimo,
    required final Direccion direccion,
  }) = _$NegocioImpl;

  @override
  String get id;
  @override
  String get nombre;
  @override
  String get categoria;
  @override
  String get logoUrl;
  @override
  double get calificacion;
  @override
  bool get abierto;
  @override
  int get tiempoEstimadoMin;
  @override
  double get costoEnvioBase;
  @override
  double get pedidoMinimo;
  @override
  Direccion get direccion;

  /// Create a copy of Negocio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NegocioImplCopyWith<_$NegocioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
