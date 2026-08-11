// lib/features/catalogo/domain/entities/negocio.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

part 'negocio.freezed.dart';

/// [costoEnvioBase] y [pedidoMinimo] están en SOLES (double) por ser
/// configuración (sección 4 del Prompt Maestro). La conversión a centavos
/// para cálculos de pedido ocurre en checkout: `(valor * 100).round()`.
@freezed
class Negocio with _$Negocio {
  const factory Negocio({
    required String id,
    required String nombre,
    required String categoria,
    required String logoUrl,
    required double calificacion,
    required bool abierto,
    required int tiempoEstimadoMin,
    required double costoEnvioBase,
    required double pedidoMinimo,
    required Direccion direccion,
  }) = _Negocio;
}
