import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';

class DireccionEntregaDto {
  final String id;
  final String etiqueta;
  final String direccionTexto;
  final double lat;
  final double lng;
  final String? referencia;

  const DireccionEntregaDto({
    required this.id,
    required this.etiqueta,
    required this.direccionTexto,
    required this.lat,
    required this.lng,
    this.referencia,
  });

  factory DireccionEntregaDto.fromJson(Map<String, dynamic> json) {
    return DireccionEntregaDto(
      id: json['id']?.toString() ?? '',
      etiqueta: json['etiqueta'] as String? ?? '',
      direccionTexto: json['direccion_texto'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      referencia: json['referencia'] as String?,
    );
  }

  Direccion toEntity() => Direccion(
        id: id,
        etiqueta: etiqueta,
        direccionTexto: direccionTexto,
        lat: lat,
        lng: lng,
        referencia: referencia,
      );
}

class ItemPedidoDto {
  final String id;
  final String productoId;
  final int cantidad;
  final int precioUnitarioCentavos;
  final String? notas;
  final Producto? producto;

  const ItemPedidoDto({
    required this.id,
    required this.productoId,
    required this.cantidad,
    required this.precioUnitarioCentavos,
    this.notas,
    this.producto,
  });

  factory ItemPedidoDto.fromJson(Map<String, dynamic> json) {
    return ItemPedidoDto(
      id: json['id']?.toString() ?? '',
      productoId: json['producto_id']?.toString() ?? '',
      cantidad: (json['cantidad'] as num?)?.toInt() ?? 0,
      precioUnitarioCentavos: (json['precio_unitario_centavos'] as num?)?.toInt() ?? 0,
      notas: json['notas'] as String?,
      producto: json['producto'] != null
          ? Producto(
              id: (json['producto']['id'] as num?)?.toString() ?? '',
              negocioId: (json['producto']['negocio_id'] as num?)?.toString() ?? '',
              nombre: json['producto']['nombre'] as String? ?? '',
              descripcion: json['producto']['descripcion'] as String?,
              precioEnCentavos: (json['producto']['precio_centavos'] as num?)?.toInt() ?? 0,
              imagenUrl: json['producto']['imagen_url'] as String?,
              disponible: json['producto']['disponible'] == true || json['producto']['disponible'] == 1,
              seccionMenu: json['producto']['seccion_menu'] as String?,
            )
          : null,
    );
  }

  ItemCarrito? toItemCarrito() {
    if (producto == null) return null;
    return ItemCarrito(
      producto: producto!,
      cantidad: cantidad,
      notas: notas,
    );
  }
}

class PedidoDto {
  final String id;
  final String negocioId;
  final String estado;
  final String metodoPago;
  final int subtotalCentavos;
  final int costoEnvioCentavos;
  final int totalCentavos;
  final DireccionEntregaDto? direccionEntrega;
  final String? creadoEn;
  final List<ItemPedidoDto> items;
  final String? clienteNombre;
  final String? clienteTelefono;

  const PedidoDto({
    required this.id,
    required this.negocioId,
    required this.estado,
    required this.metodoPago,
    required this.subtotalCentavos,
    required this.costoEnvioCentavos,
    required this.totalCentavos,
    this.direccionEntrega,
    this.creadoEn,
    required this.items,
    this.clienteNombre,
    this.clienteTelefono,
  });

  factory PedidoDto.fromJson(Map<String, dynamic> json) {
    return PedidoDto(
      id: json['id']?.toString() ?? '',
      negocioId: json['negocio_id']?.toString() ?? '',
      estado: json['estado'] as String? ?? 'pendiente',
      metodoPago: json['metodo_pago'] as String? ?? 'efectivo',
      subtotalCentavos: (json['subtotal_centavos'] as num?)?.toInt() ?? 0,
      costoEnvioCentavos: (json['costo_envio_centavos'] as num?)?.toInt() ?? 0,
      totalCentavos: (json['total_centavos'] as num?)?.toInt() ?? 0,
      direccionEntrega: json['direccion_entrega'] != null
          ? DireccionEntregaDto.fromJson(json['direccion_entrega'] as Map<String, dynamic>)
          : null,
      creadoEn: json['creado_en'] as String?,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((i) => ItemPedidoDto.fromJson(i as Map<String, dynamic>))
          .toList(),
      clienteNombre: json['usuario'] != null
          ? (json['usuario']['nombre'] as String?)
          : null,
      clienteTelefono: json['usuario'] != null
          ? (json['usuario']['telefono'] as String?)
          : null,
    );
  }

  Pedido toEntity() => Pedido(
        id: id,
        negocioId: negocioId,
        items: items
            .map((i) => i.toItemCarrito())
            .whereType<ItemCarrito>()
            .toList(),
        estado: EstadoPedido.values.firstWhere(
          (e) => e.name == estado,
          orElse: () => EstadoPedido.pendiente,
        ),
        metodoPago: MetodoPago.values.firstWhere(
          (m) => m.name == metodoPago,
          orElse: () => MetodoPago.efectivo,
        ),
        subtotalEnCentavos: subtotalCentavos,
        costoEnvioEnCentavos: costoEnvioCentavos,
        totalEnCentavos: totalCentavos,
        direccionEntrega: direccionEntrega?.toEntity() ??
            Direccion(
              id: '',
              etiqueta: '',
              direccionTexto: '',
              lat: 0,
              lng: 0,
            ),
        creadoEn: creadoEn != null ? DateTime.parse(creadoEn!) : DateTime.now(),
        clienteNombre: clienteNombre,
        clienteTelefono: clienteTelefono,
      );
}

class CrearPedidoRequestDto {
  final String negocioId;
  final List<Map<String, dynamic>> items;
  final String direccionEntregaId;
  final String metodoPago;

  const CrearPedidoRequestDto({
    required this.negocioId,
    required this.items,
    required this.direccionEntregaId,
    required this.metodoPago,
  });

  Map<String, dynamic> toJson() => {
        'negocio_id': int.tryParse(negocioId) ?? negocioId,
        'items': items,
        'direccion_entrega_id': int.tryParse(direccionEntregaId) ?? direccionEntregaId,
        'metodo_pago': metodoPago,
      };
}
