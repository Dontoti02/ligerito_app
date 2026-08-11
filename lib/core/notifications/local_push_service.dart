// lib/core/notifications/local_push_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ligerito/core/notifications/push_service.dart';

/// Notificaciones locales con sonido distintivo del canal `ligerito_pedidos`.
/// Cubre el criterio 8.5 (push + sonido) sin requerir Firebase en el MVP.
class LocalPushService implements PushService {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalPushService([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _canalId = 'ligerito_pedidos';
  static const _canalNombre = 'Pedidos Ligerito';
  static const _canalDescripcion = 'Notificaciones de pedidos nuevos y estados';

  @override
  Future<void> inicializar() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings);

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _canalId,
            _canalNombre,
            description: _canalDescripcion,
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
          ),
        );
  }

  @override
  Future<bool> solicitarPermiso() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestNotificationsPermission();
    return granted ?? true;
  }

  @override
  Future<void> mostrarNotificacionPedido({
    required String titulo,
    required String cuerpo,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _canalId,
        _canalNombre,
        channelDescription: _canalDescripcion,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      titulo,
      cuerpo,
      details,
    );
  }
}
