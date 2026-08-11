// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direcciones_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DireccionesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(List<Direccion> direcciones) loaded,
    required TResult Function(String mensaje) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(List<Direccion> direcciones)? loaded,
    TResult? Function(String mensaje)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(List<Direccion> direcciones)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cargando value) cargando,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Cargando value)? cargando,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cargando value)? cargando,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DireccionesStateCopyWith<$Res> {
  factory $DireccionesStateCopyWith(
    DireccionesState value,
    $Res Function(DireccionesState) then,
  ) = _$DireccionesStateCopyWithImpl<$Res, DireccionesState>;
}

/// @nodoc
class _$DireccionesStateCopyWithImpl<$Res, $Val extends DireccionesState>
    implements $DireccionesStateCopyWith<$Res> {
  _$DireccionesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CargandoImplCopyWith<$Res> {
  factory _$$CargandoImplCopyWith(
    _$CargandoImpl value,
    $Res Function(_$CargandoImpl) then,
  ) = __$$CargandoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CargandoImplCopyWithImpl<$Res>
    extends _$DireccionesStateCopyWithImpl<$Res, _$CargandoImpl>
    implements _$$CargandoImplCopyWith<$Res> {
  __$$CargandoImplCopyWithImpl(
    _$CargandoImpl _value,
    $Res Function(_$CargandoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CargandoImpl implements _Cargando {
  const _$CargandoImpl();

  @override
  String toString() {
    return 'DireccionesState.cargando()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CargandoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(List<Direccion> direcciones) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return cargando();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(List<Direccion> direcciones)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return cargando?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(List<Direccion> direcciones)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (cargando != null) {
      return cargando();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cargando value) cargando,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return cargando(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Cargando value)? cargando,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return cargando?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cargando value)? cargando,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (cargando != null) {
      return cargando(this);
    }
    return orElse();
  }
}

abstract class _Cargando implements DireccionesState {
  const factory _Cargando() = _$CargandoImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Direccion> direcciones});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DireccionesStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? direcciones = null}) {
    return _then(
      _$LoadedImpl(
        null == direcciones
            ? _value._direcciones
            : direcciones // ignore: cast_nullable_to_non_nullable
                  as List<Direccion>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Direccion> direcciones)
    : _direcciones = direcciones;

  final List<Direccion> _direcciones;
  @override
  List<Direccion> get direcciones {
    if (_direcciones is EqualUnmodifiableListView) return _direcciones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_direcciones);
  }

  @override
  String toString() {
    return 'DireccionesState.loaded(direcciones: $direcciones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._direcciones,
              _direcciones,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_direcciones),
  );

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(List<Direccion> direcciones) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return loaded(direcciones);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(List<Direccion> direcciones)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return loaded?.call(direcciones);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(List<Direccion> direcciones)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(direcciones);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cargando value) cargando,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Cargando value)? cargando,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cargando value)? cargando,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements DireccionesState {
  const factory _Loaded(final List<Direccion> direcciones) = _$LoadedImpl;

  List<Direccion> get direcciones;

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mensaje});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$DireccionesStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mensaje = null}) {
    return _then(
      _$ErrorImpl(
        null == mensaje
            ? _value.mensaje
            : mensaje // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.mensaje);

  @override
  final String mensaje;

  @override
  String toString() {
    return 'DireccionesState.error(mensaje: $mensaje)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.mensaje, mensaje) || other.mensaje == mensaje));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mensaje);

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(List<Direccion> direcciones) loaded,
    required TResult Function(String mensaje) error,
  }) {
    return error(mensaje);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(List<Direccion> direcciones)? loaded,
    TResult? Function(String mensaje)? error,
  }) {
    return error?.call(mensaje);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(List<Direccion> direcciones)? loaded,
    TResult Function(String mensaje)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(mensaje);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cargando value) cargando,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Cargando value)? cargando,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cargando value)? cargando,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DireccionesState {
  const factory _Error(final String mensaje) = _$ErrorImpl;

  String get mensaje;

  /// Create a copy of DireccionesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
