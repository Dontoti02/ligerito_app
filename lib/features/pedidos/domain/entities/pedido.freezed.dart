// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pedido.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Pedido {
  String get id => throw _privateConstructorUsedError;
  String get negocioId => throw _privateConstructorUsedError;
  List<ItemCarrito> get items => throw _privateConstructorUsedError;
  EstadoPedido get estado => throw _privateConstructorUsedError;
  MetodoPago get metodoPago => throw _privateConstructorUsedError;
  int get subtotalEnCentavos => throw _privateConstructorUsedError;
  int get costoEnvioEnCentavos => throw _privateConstructorUsedError;
  int get totalEnCentavos => throw _privateConstructorUsedError;
  Direccion get direccionEntrega => throw _privateConstructorUsedError;
  DateTime get creadoEn =>
      throw _privateConstructorUsedError; // Para el card de pedido entrante del panel negocio (criterio 8.5).
  String? get clienteNombre => throw _privateConstructorUsedError;
  String? get clienteTelefono => throw _privateConstructorUsedError;

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PedidoCopyWith<Pedido> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PedidoCopyWith<$Res> {
  factory $PedidoCopyWith(Pedido value, $Res Function(Pedido) then) =
      _$PedidoCopyWithImpl<$Res, Pedido>;
  @useResult
  $Res call({
    String id,
    String negocioId,
    List<ItemCarrito> items,
    EstadoPedido estado,
    MetodoPago metodoPago,
    int subtotalEnCentavos,
    int costoEnvioEnCentavos,
    int totalEnCentavos,
    Direccion direccionEntrega,
    DateTime creadoEn,
    String? clienteNombre,
    String? clienteTelefono,
  });

  $DireccionCopyWith<$Res> get direccionEntrega;
}

/// @nodoc
class _$PedidoCopyWithImpl<$Res, $Val extends Pedido>
    implements $PedidoCopyWith<$Res> {
  _$PedidoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? negocioId = null,
    Object? items = null,
    Object? estado = null,
    Object? metodoPago = null,
    Object? subtotalEnCentavos = null,
    Object? costoEnvioEnCentavos = null,
    Object? totalEnCentavos = null,
    Object? direccionEntrega = null,
    Object? creadoEn = null,
    Object? clienteNombre = freezed,
    Object? clienteTelefono = freezed,
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
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ItemCarrito>,
            estado: null == estado
                ? _value.estado
                : estado // ignore: cast_nullable_to_non_nullable
                      as EstadoPedido,
            metodoPago: null == metodoPago
                ? _value.metodoPago
                : metodoPago // ignore: cast_nullable_to_non_nullable
                      as MetodoPago,
            subtotalEnCentavos: null == subtotalEnCentavos
                ? _value.subtotalEnCentavos
                : subtotalEnCentavos // ignore: cast_nullable_to_non_nullable
                      as int,
            costoEnvioEnCentavos: null == costoEnvioEnCentavos
                ? _value.costoEnvioEnCentavos
                : costoEnvioEnCentavos // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEnCentavos: null == totalEnCentavos
                ? _value.totalEnCentavos
                : totalEnCentavos // ignore: cast_nullable_to_non_nullable
                      as int,
            direccionEntrega: null == direccionEntrega
                ? _value.direccionEntrega
                : direccionEntrega // ignore: cast_nullable_to_non_nullable
                      as Direccion,
            creadoEn: null == creadoEn
                ? _value.creadoEn
                : creadoEn // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            clienteNombre: freezed == clienteNombre
                ? _value.clienteNombre
                : clienteNombre // ignore: cast_nullable_to_non_nullable
                      as String?,
            clienteTelefono: freezed == clienteTelefono
                ? _value.clienteTelefono
                : clienteTelefono // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DireccionCopyWith<$Res> get direccionEntrega {
    return $DireccionCopyWith<$Res>(_value.direccionEntrega, (value) {
      return _then(_value.copyWith(direccionEntrega: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PedidoImplCopyWith<$Res> implements $PedidoCopyWith<$Res> {
  factory _$$PedidoImplCopyWith(
    _$PedidoImpl value,
    $Res Function(_$PedidoImpl) then,
  ) = __$$PedidoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String negocioId,
    List<ItemCarrito> items,
    EstadoPedido estado,
    MetodoPago metodoPago,
    int subtotalEnCentavos,
    int costoEnvioEnCentavos,
    int totalEnCentavos,
    Direccion direccionEntrega,
    DateTime creadoEn,
    String? clienteNombre,
    String? clienteTelefono,
  });

  @override
  $DireccionCopyWith<$Res> get direccionEntrega;
}

/// @nodoc
class __$$PedidoImplCopyWithImpl<$Res>
    extends _$PedidoCopyWithImpl<$Res, _$PedidoImpl>
    implements _$$PedidoImplCopyWith<$Res> {
  __$$PedidoImplCopyWithImpl(
    _$PedidoImpl _value,
    $Res Function(_$PedidoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? negocioId = null,
    Object? items = null,
    Object? estado = null,
    Object? metodoPago = null,
    Object? subtotalEnCentavos = null,
    Object? costoEnvioEnCentavos = null,
    Object? totalEnCentavos = null,
    Object? direccionEntrega = null,
    Object? creadoEn = null,
    Object? clienteNombre = freezed,
    Object? clienteTelefono = freezed,
  }) {
    return _then(
      _$PedidoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        negocioId: null == negocioId
            ? _value.negocioId
            : negocioId // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ItemCarrito>,
        estado: null == estado
            ? _value.estado
            : estado // ignore: cast_nullable_to_non_nullable
                  as EstadoPedido,
        metodoPago: null == metodoPago
            ? _value.metodoPago
            : metodoPago // ignore: cast_nullable_to_non_nullable
                  as MetodoPago,
        subtotalEnCentavos: null == subtotalEnCentavos
            ? _value.subtotalEnCentavos
            : subtotalEnCentavos // ignore: cast_nullable_to_non_nullable
                  as int,
        costoEnvioEnCentavos: null == costoEnvioEnCentavos
            ? _value.costoEnvioEnCentavos
            : costoEnvioEnCentavos // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEnCentavos: null == totalEnCentavos
            ? _value.totalEnCentavos
            : totalEnCentavos // ignore: cast_nullable_to_non_nullable
                  as int,
        direccionEntrega: null == direccionEntrega
            ? _value.direccionEntrega
            : direccionEntrega // ignore: cast_nullable_to_non_nullable
                  as Direccion,
        creadoEn: null == creadoEn
            ? _value.creadoEn
            : creadoEn // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        clienteNombre: freezed == clienteNombre
            ? _value.clienteNombre
            : clienteNombre // ignore: cast_nullable_to_non_nullable
                  as String?,
        clienteTelefono: freezed == clienteTelefono
            ? _value.clienteTelefono
            : clienteTelefono // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PedidoImpl implements _Pedido {
  const _$PedidoImpl({
    required this.id,
    required this.negocioId,
    required final List<ItemCarrito> items,
    required this.estado,
    required this.metodoPago,
    required this.subtotalEnCentavos,
    required this.costoEnvioEnCentavos,
    required this.totalEnCentavos,
    required this.direccionEntrega,
    required this.creadoEn,
    this.clienteNombre,
    this.clienteTelefono,
  }) : _items = items;

  @override
  final String id;
  @override
  final String negocioId;
  final List<ItemCarrito> _items;
  @override
  List<ItemCarrito> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final EstadoPedido estado;
  @override
  final MetodoPago metodoPago;
  @override
  final int subtotalEnCentavos;
  @override
  final int costoEnvioEnCentavos;
  @override
  final int totalEnCentavos;
  @override
  final Direccion direccionEntrega;
  @override
  final DateTime creadoEn;
  // Para el card de pedido entrante del panel negocio (criterio 8.5).
  @override
  final String? clienteNombre;
  @override
  final String? clienteTelefono;

  @override
  String toString() {
    return 'Pedido(id: $id, negocioId: $negocioId, items: $items, estado: $estado, metodoPago: $metodoPago, subtotalEnCentavos: $subtotalEnCentavos, costoEnvioEnCentavos: $costoEnvioEnCentavos, totalEnCentavos: $totalEnCentavos, direccionEntrega: $direccionEntrega, creadoEn: $creadoEn, clienteNombre: $clienteNombre, clienteTelefono: $clienteTelefono)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PedidoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.negocioId, negocioId) ||
                other.negocioId == negocioId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.estado, estado) || other.estado == estado) &&
            (identical(other.metodoPago, metodoPago) ||
                other.metodoPago == metodoPago) &&
            (identical(other.subtotalEnCentavos, subtotalEnCentavos) ||
                other.subtotalEnCentavos == subtotalEnCentavos) &&
            (identical(other.costoEnvioEnCentavos, costoEnvioEnCentavos) ||
                other.costoEnvioEnCentavos == costoEnvioEnCentavos) &&
            (identical(other.totalEnCentavos, totalEnCentavos) ||
                other.totalEnCentavos == totalEnCentavos) &&
            (identical(other.direccionEntrega, direccionEntrega) ||
                other.direccionEntrega == direccionEntrega) &&
            (identical(other.creadoEn, creadoEn) ||
                other.creadoEn == creadoEn) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.clienteTelefono, clienteTelefono) ||
                other.clienteTelefono == clienteTelefono));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    negocioId,
    const DeepCollectionEquality().hash(_items),
    estado,
    metodoPago,
    subtotalEnCentavos,
    costoEnvioEnCentavos,
    totalEnCentavos,
    direccionEntrega,
    creadoEn,
    clienteNombre,
    clienteTelefono,
  );

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PedidoImplCopyWith<_$PedidoImpl> get copyWith =>
      __$$PedidoImplCopyWithImpl<_$PedidoImpl>(this, _$identity);
}

abstract class _Pedido implements Pedido {
  const factory _Pedido({
    required final String id,
    required final String negocioId,
    required final List<ItemCarrito> items,
    required final EstadoPedido estado,
    required final MetodoPago metodoPago,
    required final int subtotalEnCentavos,
    required final int costoEnvioEnCentavos,
    required final int totalEnCentavos,
    required final Direccion direccionEntrega,
    required final DateTime creadoEn,
    final String? clienteNombre,
    final String? clienteTelefono,
  }) = _$PedidoImpl;

  @override
  String get id;
  @override
  String get negocioId;
  @override
  List<ItemCarrito> get items;
  @override
  EstadoPedido get estado;
  @override
  MetodoPago get metodoPago;
  @override
  int get subtotalEnCentavos;
  @override
  int get costoEnvioEnCentavos;
  @override
  int get totalEnCentavos;
  @override
  Direccion get direccionEntrega;
  @override
  DateTime get creadoEn; // Para el card de pedido entrante del panel negocio (criterio 8.5).
  @override
  String? get clienteNombre;
  @override
  String? get clienteTelefono;

  /// Create a copy of Pedido
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PedidoImplCopyWith<_$PedidoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
