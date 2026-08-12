// lib/core/constants/api_endpoints.dart
class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.56.1:8000',
  );

  static const login = '/api/auth/login';
  static const register = '/api/auth/register';
  static const refresh = '/api/auth/refresh';
  static const logout = '/api/auth/logout';
  static const negocios = '/api/negocios';
  static String negocioDetalle(String id) => '/api/negocios/$id';
  static String productosNegocio(String negocioId) => '/api/negocios/$negocioId/productos';
  static const direcciones = '/api/direcciones';
  static String direccionDetalle(String id) => '/api/direcciones/$id';
  static const pedidos = '/api/pedidos';
  static String pedidoDetalle(String id) => '/api/pedidos/$id';
  static String pedidoEstado(String id) => '/api/negocio/pedidos/$id/estado';
  static const pedidosEntrantes = '/api/negocio/pedidos-entrantes';
  static const productos = '/api/negocio/productos';
}
