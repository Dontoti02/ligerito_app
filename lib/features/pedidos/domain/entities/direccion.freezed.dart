// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direccion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Direccion {
  String get id => throw _privateConstructorUsedError;
  String get etiqueta => throw _privateConstructorUsedError;
  String get direccionTexto => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get referencia => throw _privateConstructorUsedError;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DireccionCopyWith<Direccion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DireccionCopyWith<$Res> {
  factory $DireccionCopyWith(Direccion value, $Res Function(Direccion) then) =
      _$DireccionCopyWithImpl<$Res, Direccion>;
  @useResult
  $Res call({
    String id,
    String etiqueta,
    String direccionTexto,
    double lat,
    double lng,
    String? referencia,
  });
}

/// @nodoc
class _$DireccionCopyWithImpl<$Res, $Val extends Direccion>
    implements $DireccionCopyWith<$Res> {
  _$DireccionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? etiqueta = null,
    Object? direccionTexto = null,
    Object? lat = null,
    Object? lng = null,
    Object? referencia = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            etiqueta: null == etiqueta
                ? _value.etiqueta
                : etiqueta // ignore: cast_nullable_to_non_nullable
                      as String,
            direccionTexto: null == direccionTexto
                ? _value.direccionTexto
                : direccionTexto // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            referencia: freezed == referencia
                ? _value.referencia
                : referencia // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DireccionImplCopyWith<$Res>
    implements $DireccionCopyWith<$Res> {
  factory _$$DireccionImplCopyWith(
    _$DireccionImpl value,
    $Res Function(_$DireccionImpl) then,
  ) = __$$DireccionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String etiqueta,
    String direccionTexto,
    double lat,
    double lng,
    String? referencia,
  });
}

/// @nodoc
class __$$DireccionImplCopyWithImpl<$Res>
    extends _$DireccionCopyWithImpl<$Res, _$DireccionImpl>
    implements _$$DireccionImplCopyWith<$Res> {
  __$$DireccionImplCopyWithImpl(
    _$DireccionImpl _value,
    $Res Function(_$DireccionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? etiqueta = null,
    Object? direccionTexto = null,
    Object? lat = null,
    Object? lng = null,
    Object? referencia = freezed,
  }) {
    return _then(
      _$DireccionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        etiqueta: null == etiqueta
            ? _value.etiqueta
            : etiqueta // ignore: cast_nullable_to_non_nullable
                  as String,
        direccionTexto: null == direccionTexto
            ? _value.direccionTexto
            : direccionTexto // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        referencia: freezed == referencia
            ? _value.referencia
            : referencia // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DireccionImpl implements _Direccion {
  const _$DireccionImpl({
    required this.id,
    required this.etiqueta,
    required this.direccionTexto,
    required this.lat,
    required this.lng,
    this.referencia,
  });

  @override
  final String id;
  @override
  final String etiqueta;
  @override
  final String direccionTexto;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? referencia;

  @override
  String toString() {
    return 'Direccion(id: $id, etiqueta: $etiqueta, direccionTexto: $direccionTexto, lat: $lat, lng: $lng, referencia: $referencia)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DireccionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.etiqueta, etiqueta) ||
                other.etiqueta == etiqueta) &&
            (identical(other.direccionTexto, direccionTexto) ||
                other.direccionTexto == direccionTexto) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.referencia, referencia) ||
                other.referencia == referencia));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    etiqueta,
    direccionTexto,
    lat,
    lng,
    referencia,
  );

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DireccionImplCopyWith<_$DireccionImpl> get copyWith =>
      __$$DireccionImplCopyWithImpl<_$DireccionImpl>(this, _$identity);
}

abstract class _Direccion implements Direccion {
  const factory _Direccion({
    required final String id,
    required final String etiqueta,
    required final String direccionTexto,
    required final double lat,
    required final double lng,
    final String? referencia,
  }) = _$DireccionImpl;

  @override
  String get id;
  @override
  String get etiqueta;
  @override
  String get direccionTexto;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get referencia;

  /// Create a copy of Direccion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DireccionImplCopyWith<_$DireccionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
