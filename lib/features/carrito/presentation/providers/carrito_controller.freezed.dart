// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carrito_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CarritoState {
  List<ItemCarrito> get items => throw _privateConstructorUsedError;
  String? get negocioId => throw _privateConstructorUsedError;
  String? get negocioNombre => throw _privateConstructorUsedError;

  /// Create a copy of CarritoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarritoStateCopyWith<CarritoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarritoStateCopyWith<$Res> {
  factory $CarritoStateCopyWith(
    CarritoState value,
    $Res Function(CarritoState) then,
  ) = _$CarritoStateCopyWithImpl<$Res, CarritoState>;
  @useResult
  $Res call({
    List<ItemCarrito> items,
    String? negocioId,
    String? negocioNombre,
  });
}

/// @nodoc
class _$CarritoStateCopyWithImpl<$Res, $Val extends CarritoState>
    implements $CarritoStateCopyWith<$Res> {
  _$CarritoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarritoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? negocioId = freezed,
    Object? negocioNombre = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ItemCarrito>,
            negocioId: freezed == negocioId
                ? _value.negocioId
                : negocioId // ignore: cast_nullable_to_non_nullable
                      as String?,
            negocioNombre: freezed == negocioNombre
                ? _value.negocioNombre
                : negocioNombre // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CarritoStateImplCopyWith<$Res>
    implements $CarritoStateCopyWith<$Res> {
  factory _$$CarritoStateImplCopyWith(
    _$CarritoStateImpl value,
    $Res Function(_$CarritoStateImpl) then,
  ) = __$$CarritoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ItemCarrito> items,
    String? negocioId,
    String? negocioNombre,
  });
}

/// @nodoc
class __$$CarritoStateImplCopyWithImpl<$Res>
    extends _$CarritoStateCopyWithImpl<$Res, _$CarritoStateImpl>
    implements _$$CarritoStateImplCopyWith<$Res> {
  __$$CarritoStateImplCopyWithImpl(
    _$CarritoStateImpl _value,
    $Res Function(_$CarritoStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CarritoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? negocioId = freezed,
    Object? negocioNombre = freezed,
  }) {
    return _then(
      _$CarritoStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ItemCarrito>,
        negocioId: freezed == negocioId
            ? _value.negocioId
            : negocioId // ignore: cast_nullable_to_non_nullable
                  as String?,
        negocioNombre: freezed == negocioNombre
            ? _value.negocioNombre
            : negocioNombre // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CarritoStateImpl implements _CarritoState {
  const _$CarritoStateImpl({
    final List<ItemCarrito> items = const [],
    this.negocioId,
    this.negocioNombre,
  }) : _items = items;

  final List<ItemCarrito> _items;
  @override
  @JsonKey()
  List<ItemCarrito> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? negocioId;
  @override
  final String? negocioNombre;

  @override
  String toString() {
    return 'CarritoState(items: $items, negocioId: $negocioId, negocioNombre: $negocioNombre)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarritoStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.negocioId, negocioId) ||
                other.negocioId == negocioId) &&
            (identical(other.negocioNombre, negocioNombre) ||
                other.negocioNombre == negocioNombre));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    negocioId,
    negocioNombre,
  );

  /// Create a copy of CarritoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarritoStateImplCopyWith<_$CarritoStateImpl> get copyWith =>
      __$$CarritoStateImplCopyWithImpl<_$CarritoStateImpl>(this, _$identity);
}

abstract class _CarritoState implements CarritoState {
  const factory _CarritoState({
    final List<ItemCarrito> items,
    final String? negocioId,
    final String? negocioNombre,
  }) = _$CarritoStateImpl;

  @override
  List<ItemCarrito> get items;
  @override
  String? get negocioId;
  @override
  String? get negocioNombre;

  /// Create a copy of CarritoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarritoStateImplCopyWith<_$CarritoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
