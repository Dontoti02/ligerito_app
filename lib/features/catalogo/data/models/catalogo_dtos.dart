import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

class DireccionDto {
  final String id;
  final String etiqueta;
  final String direccionTexto;
  final double lat;
  final double lng;
  final String? referencia;

  const DireccionDto({
    required this.id,
    required this.etiqueta,
    required this.direccionTexto,
    required this.lat,
    required this.lng,
    this.referencia,
  });

  factory DireccionDto.fromJson(Map<String, dynamic> json) {
    return DireccionDto(
      id: json['id']?.toString() ?? '',
      etiqueta: json['etiqueta'] as String? ?? '',
      direccionTexto: json['direccion_texto'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      referencia: json['referencia'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'etiqueta': etiqueta,
        'direccion_texto': direccionTexto,
        'lat': lat,
        'lng': lng,
        'referencia': referencia,
      };

  Direccion toEntity() => Direccion(
        id: id,
        etiqueta: etiqueta,
        direccionTexto: direccionTexto,
        lat: lat,
        lng: lng,
        referencia: referencia,
      );
}

class NegocioDto {
  final String id;
  final String nombre;
  final String categoria;
  final String? logoUrl;
  final double calificacion;
  final bool abierto;
  final int tiempoEstimadoMin;
  final int costoEnvioBaseCentavos;
  final int pedidoMinimoCentavos;
  final double comisionPorcentaje;
  final DireccionDto? direccion;

  const NegocioDto({
    required this.id,
    required this.nombre,
    required this.categoria,
    this.logoUrl,
    required this.calificacion,
    required this.abierto,
    required this.tiempoEstimadoMin,
    required this.costoEnvioBaseCentavos,
    required this.pedidoMinimoCentavos,
    required this.comisionPorcentaje,
    this.direccion,
  });

  factory NegocioDto.fromJson(Map<String, dynamic> json) {
    return NegocioDto(
      id: json['id']?.toString() ?? '',
      nombre: json['nombre'] as String? ?? '',
      categoria: json['categoria'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      calificacion: (json['calificacion'] as num?)?.toDouble() ?? 0,
      abierto: json['abierto'] == true || json['abierto'] == 1,
      tiempoEstimadoMin: (json['tiempo_estimado_min'] as num?)?.toInt() ?? 0,
      costoEnvioBaseCentavos: (json['costo_envio_base'] as num?)?.toInt() ?? 0,
      pedidoMinimoCentavos: (json['pedido_minimo'] as num?)?.toInt() ?? 0,
      comisionPorcentaje: (json['comision_porcentaje'] as num?)?.toDouble() ?? 0,
      direccion: json['direccion'] != null
          ? DireccionDto.fromJson(json['direccion'] as Map<String, dynamic>)
          : null,
    );
  }

  Negocio toEntity() => Negocio(
        id: id,
        nombre: nombre,
        categoria: categoria,
        logoUrl: logoUrl ?? '',
        calificacion: calificacion,
        abierto: abierto,
        tiempoEstimadoMin: tiempoEstimadoMin,
        costoEnvioBase: costoEnvioBaseCentavos / 100,
        pedidoMinimo: pedidoMinimoCentavos / 100,
        direccion: direccion?.toEntity() ??
            Direccion(
              id: '',
              etiqueta: '',
              direccionTexto: '',
              lat: -5.1783,
              lng: -80.6549,
            ),
      );
}

class ProductoDto {
  final String id;
  final String negocioId;
  final String nombre;
  final String? descripcion;
  final int precioCentavos;
  final String? imagenUrl;
  final bool disponible;
  final String? seccionMenu;

  const ProductoDto({
    required this.id,
    required this.negocioId,
    required this.nombre,
    this.descripcion,
    required this.precioCentavos,
    this.imagenUrl,
    required this.disponible,
    this.seccionMenu,
  });

  factory ProductoDto.fromJson(Map<String, dynamic> json) {
    return ProductoDto(
      id: json['id']?.toString() ?? '',
      negocioId: json['negocio_id']?.toString() ?? '',
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String?,
      precioCentavos: (json['precio_centavos'] as num?)?.toInt() ?? 0,
      imagenUrl: json['imagen_url'] as String?,
      disponible: json['disponible'] == true || json['disponible'] == 1,
      seccionMenu: json['seccion_menu'] as String?,
    );
  }

  Producto toEntity() => Producto(
        id: id,
        negocioId: negocioId,
        nombre: nombre,
        descripcion: descripcion,
        precioEnCentavos: precioCentavos,
        imagenUrl: imagenUrl,
        disponible: disponible,
        seccionMenu: seccionMenu,
      );
}
