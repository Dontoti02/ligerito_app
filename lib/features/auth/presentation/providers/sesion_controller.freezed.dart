// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sesion_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SesionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(Usuario usuario) autenticado,
    required TResult Function(String? error) noAutenticado,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(Usuario usuario)? autenticado,
    TResult? Function(String? error)? noAutenticado,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(Usuario usuario)? autenticado,
    TResult Function(String? error)? noAutenticado,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SesionCargando value) cargando,
    required TResult Function(SesionAutenticada value) autenticado,
    required TResult Function(SesionNoAutenticada value) noAutenticado,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SesionCargando value)? cargando,
    TResult? Function(SesionAutenticada value)? autenticado,
    TResult? Function(SesionNoAutenticada value)? noAutenticado,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SesionCargando value)? cargando,
    TResult Function(SesionAutenticada value)? autenticado,
    TResult Function(SesionNoAutenticada value)? noAutenticado,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SesionStateCopyWith<$Res> {
  factory $SesionStateCopyWith(
    SesionState value,
    $Res Function(SesionState) then,
  ) = _$SesionStateCopyWithImpl<$Res, SesionState>;
}

/// @nodoc
class _$SesionStateCopyWithImpl<$Res, $Val extends SesionState>
    implements $SesionStateCopyWith<$Res> {
  _$SesionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SesionCargandoImplCopyWith<$Res> {
  factory _$$SesionCargandoImplCopyWith(
    _$SesionCargandoImpl value,
    $Res Function(_$SesionCargandoImpl) then,
  ) = __$$SesionCargandoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SesionCargandoImplCopyWithImpl<$Res>
    extends _$SesionStateCopyWithImpl<$Res, _$SesionCargandoImpl>
    implements _$$SesionCargandoImplCopyWith<$Res> {
  __$$SesionCargandoImplCopyWithImpl(
    _$SesionCargandoImpl _value,
    $Res Function(_$SesionCargandoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SesionCargandoImpl implements SesionCargando {
  const _$SesionCargandoImpl();

  @override
  String toString() {
    return 'SesionState.cargando()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SesionCargandoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(Usuario usuario) autenticado,
    required TResult Function(String? error) noAutenticado,
  }) {
    return cargando();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(Usuario usuario)? autenticado,
    TResult? Function(String? error)? noAutenticado,
  }) {
    return cargando?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(Usuario usuario)? autenticado,
    TResult Function(String? error)? noAutenticado,
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
    required TResult Function(SesionCargando value) cargando,
    required TResult Function(SesionAutenticada value) autenticado,
    required TResult Function(SesionNoAutenticada value) noAutenticado,
  }) {
    return cargando(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SesionCargando value)? cargando,
    TResult? Function(SesionAutenticada value)? autenticado,
    TResult? Function(SesionNoAutenticada value)? noAutenticado,
  }) {
    return cargando?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SesionCargando value)? cargando,
    TResult Function(SesionAutenticada value)? autenticado,
    TResult Function(SesionNoAutenticada value)? noAutenticado,
    required TResult orElse(),
  }) {
    if (cargando != null) {
      return cargando(this);
    }
    return orElse();
  }
}

abstract class SesionCargando implements SesionState {
  const factory SesionCargando() = _$SesionCargandoImpl;
}

/// @nodoc
abstract class _$$SesionAutenticadaImplCopyWith<$Res> {
  factory _$$SesionAutenticadaImplCopyWith(
    _$SesionAutenticadaImpl value,
    $Res Function(_$SesionAutenticadaImpl) then,
  ) = __$$SesionAutenticadaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Usuario usuario});

  $UsuarioCopyWith<$Res> get usuario;
}

/// @nodoc
class __$$SesionAutenticadaImplCopyWithImpl<$Res>
    extends _$SesionStateCopyWithImpl<$Res, _$SesionAutenticadaImpl>
    implements _$$SesionAutenticadaImplCopyWith<$Res> {
  __$$SesionAutenticadaImplCopyWithImpl(
    _$SesionAutenticadaImpl _value,
    $Res Function(_$SesionAutenticadaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usuario = null}) {
    return _then(
      _$SesionAutenticadaImpl(
        null == usuario
            ? _value.usuario
            : usuario // ignore: cast_nullable_to_non_nullable
                  as Usuario,
      ),
    );
  }

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsuarioCopyWith<$Res> get usuario {
    return $UsuarioCopyWith<$Res>(_value.usuario, (value) {
      return _then(_value.copyWith(usuario: value));
    });
  }
}

/// @nodoc

class _$SesionAutenticadaImpl implements SesionAutenticada {
  const _$SesionAutenticadaImpl(this.usuario);

  @override
  final Usuario usuario;

  @override
  String toString() {
    return 'SesionState.autenticado(usuario: $usuario)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SesionAutenticadaImpl &&
            (identical(other.usuario, usuario) || other.usuario == usuario));
  }

  @override
  int get hashCode => Object.hash(runtimeType, usuario);

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SesionAutenticadaImplCopyWith<_$SesionAutenticadaImpl> get copyWith =>
      __$$SesionAutenticadaImplCopyWithImpl<_$SesionAutenticadaImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(Usuario usuario) autenticado,
    required TResult Function(String? error) noAutenticado,
  }) {
    return autenticado(usuario);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(Usuario usuario)? autenticado,
    TResult? Function(String? error)? noAutenticado,
  }) {
    return autenticado?.call(usuario);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(Usuario usuario)? autenticado,
    TResult Function(String? error)? noAutenticado,
    required TResult orElse(),
  }) {
    if (autenticado != null) {
      return autenticado(usuario);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SesionCargando value) cargando,
    required TResult Function(SesionAutenticada value) autenticado,
    required TResult Function(SesionNoAutenticada value) noAutenticado,
  }) {
    return autenticado(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SesionCargando value)? cargando,
    TResult? Function(SesionAutenticada value)? autenticado,
    TResult? Function(SesionNoAutenticada value)? noAutenticado,
  }) {
    return autenticado?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SesionCargando value)? cargando,
    TResult Function(SesionAutenticada value)? autenticado,
    TResult Function(SesionNoAutenticada value)? noAutenticado,
    required TResult orElse(),
  }) {
    if (autenticado != null) {
      return autenticado(this);
    }
    return orElse();
  }
}

abstract class SesionAutenticada implements SesionState {
  const factory SesionAutenticada(final Usuario usuario) =
      _$SesionAutenticadaImpl;

  Usuario get usuario;

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SesionAutenticadaImplCopyWith<_$SesionAutenticadaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SesionNoAutenticadaImplCopyWith<$Res> {
  factory _$$SesionNoAutenticadaImplCopyWith(
    _$SesionNoAutenticadaImpl value,
    $Res Function(_$SesionNoAutenticadaImpl) then,
  ) = __$$SesionNoAutenticadaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? error});
}

/// @nodoc
class __$$SesionNoAutenticadaImplCopyWithImpl<$Res>
    extends _$SesionStateCopyWithImpl<$Res, _$SesionNoAutenticadaImpl>
    implements _$$SesionNoAutenticadaImplCopyWith<$Res> {
  __$$SesionNoAutenticadaImplCopyWithImpl(
    _$SesionNoAutenticadaImpl _value,
    $Res Function(_$SesionNoAutenticadaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = freezed}) {
    return _then(
      _$SesionNoAutenticadaImpl(
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SesionNoAutenticadaImpl implements SesionNoAutenticada {
  const _$SesionNoAutenticadaImpl({this.error});

  @override
  final String? error;

  @override
  String toString() {
    return 'SesionState.noAutenticado(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SesionNoAutenticadaImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SesionNoAutenticadaImplCopyWith<_$SesionNoAutenticadaImpl> get copyWith =>
      __$$SesionNoAutenticadaImplCopyWithImpl<_$SesionNoAutenticadaImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cargando,
    required TResult Function(Usuario usuario) autenticado,
    required TResult Function(String? error) noAutenticado,
  }) {
    return noAutenticado(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cargando,
    TResult? Function(Usuario usuario)? autenticado,
    TResult? Function(String? error)? noAutenticado,
  }) {
    return noAutenticado?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cargando,
    TResult Function(Usuario usuario)? autenticado,
    TResult Function(String? error)? noAutenticado,
    required TResult orElse(),
  }) {
    if (noAutenticado != null) {
      return noAutenticado(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SesionCargando value) cargando,
    required TResult Function(SesionAutenticada value) autenticado,
    required TResult Function(SesionNoAutenticada value) noAutenticado,
  }) {
    return noAutenticado(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SesionCargando value)? cargando,
    TResult? Function(SesionAutenticada value)? autenticado,
    TResult? Function(SesionNoAutenticada value)? noAutenticado,
  }) {
    return noAutenticado?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SesionCargando value)? cargando,
    TResult Function(SesionAutenticada value)? autenticado,
    TResult Function(SesionNoAutenticada value)? noAutenticado,
    required TResult orElse(),
  }) {
    if (noAutenticado != null) {
      return noAutenticado(this);
    }
    return orElse();
  }
}

abstract class SesionNoAutenticada implements SesionState {
  const factory SesionNoAutenticada({final String? error}) =
      _$SesionNoAutenticadaImpl;

  String? get error;

  /// Create a copy of SesionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SesionNoAutenticadaImplCopyWith<_$SesionNoAutenticadaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
