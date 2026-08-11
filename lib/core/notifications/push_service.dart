// lib/core/notifications/push_service.dart
/// Abstracción de notificaciones push.
///
/// MVP: implementación [LocalPushService] con flutter_local_notifications
/// (funciona sin Firebase). Para enchufar FCM en Fase 2: crear
/// `FirebasePushService implements PushService` y override del provider
/// `pushServiceProvider` en app.dart — sin tocar pantallas.
abstract class PushService {
  Future<void> inicializar();
  Future<bool> solicitarPermiso();
  Future<void> mostrarNotificacionPedido({
    required String titulo,
    required String cuerpo,
  });
}
