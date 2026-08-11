// lib/core/constants/api_endpoints.dart
class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.ligerito.pe',
  );

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refresh = '/auth/refresh';
  static const negocios = '/negocios';
  static String negocioDetalle(String id) => '/negocios/$id';
  static const pedidos = '/pedidos';
  static String pedidoDetalle(String id) => '/pedidos/$id';
  static String pedidoEstado(String id) => '/pedidos/$id/estado';
  static const pedidosEntrantes = '/negocio/pedidos-entrantes';
  static const productos = '/negocio/productos';
}
