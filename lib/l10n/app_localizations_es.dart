// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Ligerito';

  @override
  String get tagline => 'Tu pedido, al toque.';

  @override
  String get loginTitulo => '¡Qué bueno verte!';

  @override
  String get loginSubtitulo => 'Ingresa para pedir tu favorito';

  @override
  String get loginTelefono => 'Teléfono';

  @override
  String get loginPassword => 'Contraseña';

  @override
  String get loginBoton => 'Ingresar';

  @override
  String get loginSinCuenta => '¿No tienes cuenta? Regístrate';

  @override
  String get loginOlvidaste => '¿Olvidaste tu contraseña?';

  @override
  String get loginErrorCredenciales => 'Teléfono o contraseña incorrectos';

  @override
  String get registroTitulo => 'Crea tu cuenta';

  @override
  String get registroNombre => 'Nombre completo';

  @override
  String get registroEmail => 'Correo (opcional)';

  @override
  String get registroBoton => 'Registrarme';

  @override
  String get registroExito => '¡Listo! Ya eres parte de Ligerito';

  @override
  String get recuperarTitulo => 'Recuperar contraseña';

  @override
  String get recuperarBoton => 'Enviar enlace';

  @override
  String get recuperarMensaje =>
      'Te enviaremos instrucciones a tu correo o SMS';

  @override
  String get homeTitulo => '¿Qué se te antoja hoy?';

  @override
  String get homeBuscarHint => 'Busca pollerías, farmacias...';

  @override
  String get homeVacioTitulo => 'Ningún negocio cerca abierto por ahora';

  @override
  String get homeVacioSubtitulo => 'Intenta con otra categoría o vuelve pronto';

  @override
  String get categoriaTodos => 'Todos';

  @override
  String get categoriaRestaurante => 'Restaurantes';

  @override
  String get categoriaFarmacia => 'Farmacias';

  @override
  String get categoriaMercado => 'Mercados';

  @override
  String get categoriaFerreteria => 'Ferreterías';

  @override
  String get negocioAbierto => 'Abierto';

  @override
  String get negocioCerrado => 'Cerrado';

  @override
  String negocioTiempo(int min) {
    return '~$min min';
  }

  @override
  String negocioEnvio(String costo) {
    return 'Envío $costo';
  }

  @override
  String negocioPedidoMinimo(String monto) {
    return 'Mínimo $monto';
  }

  @override
  String get detalleAgregar => 'Agregar';

  @override
  String get detalleNotasHint => 'Notas (ej. sin cebolla)';

  @override
  String get detalleAgregadoSnack => 'Agregado a tu pedido';

  @override
  String get detalleMenuVacio => 'Este negocio aún no tiene productos';

  @override
  String get carritoTitulo => 'Tu pedido';

  @override
  String get carritoVacio => 'Tu carrito está vacío';

  @override
  String get carritoVacioSubtitulo => 'Agrega algo rico de un negocio';

  @override
  String get carritoConflictoTitulo => '¿Cambiar de negocio?';

  @override
  String carritoConflictoMensaje(String negocio) {
    return 'Tu carrito tiene productos de $negocio. Solo puedes pedir de un negocio a la vez.';
  }

  @override
  String get carritoConflictoConfirmar => 'Vaciar y agregar';

  @override
  String get carritoContinuar => 'Continuar';

  @override
  String carritoMinimoNoAlcanzado(String monto) {
    return 'Te falta $monto para el pedido mínimo';
  }

  @override
  String get carritoSubtotal => 'Subtotal';

  @override
  String get carritoEnvio => 'Costo de envío';

  @override
  String get carritoTotal => 'Total';

  @override
  String get checkoutTitulo => 'Confirmar pedido';

  @override
  String get checkoutDireccion => 'Dirección de entrega';

  @override
  String get checkoutMetodoPago => 'Método de pago';

  @override
  String checkoutYapeInstruccion(String numero) {
    return 'Yapea al $numero y adjunta tu captura';
  }

  @override
  String checkoutPlinInstruccion(String numero) {
    return 'Haz Plin al $numero y adjunta tu captura';
  }

  @override
  String get checkoutAdjuntarCaptura => 'Adjuntar captura (opcional)';

  @override
  String get checkoutCapturaAdjunta => 'Captura adjunta';

  @override
  String get checkoutConfirmar => 'Confirmar pedido';

  @override
  String get checkoutEfectivoNota => 'Paga en efectivo al recibir';

  @override
  String get checkoutSinDireccion => 'Elige una dirección de entrega';

  @override
  String get pedidoConfirmadoTitulo => '¡Pedido confirmado!';

  @override
  String pedidoConfirmadoMensaje(String numero) {
    return 'Tu pedido #$numero ya está con el negocio';
  }

  @override
  String get pedidoVerSeguimiento => 'Ver seguimiento';

  @override
  String get seguimientoTitulo => 'Seguimiento';

  @override
  String get seguimientoCasiLlega => '¡Ya casi llega, ligerito!';

  @override
  String get seguimientoContactar => 'Contactar al negocio';

  @override
  String get seguimientoCanceladoBanner => 'Este pedido fue cancelado';

  @override
  String seguimientoWhatsAppMensaje(String numero) {
    return 'Hola, consulto por mi pedido #$numero en Ligerito';
  }

  @override
  String get estadoPendiente => 'Pendiente';

  @override
  String get estadoConfirmado => 'Confirmado';

  @override
  String get estadoPreparando => 'Preparando';

  @override
  String get estadoEnCamino => 'En camino';

  @override
  String get estadoEntregado => 'Entregado';

  @override
  String get estadoCancelado => 'Cancelado';

  @override
  String get historialTitulo => 'Mis pedidos';

  @override
  String get historialVacio => 'Aún no tienes pedidos';

  @override
  String get historialVacioSubtitulo => 'Tu primer pedido te espera, ligerito';

  @override
  String get historialRepetir => 'Repetir pedido';

  @override
  String get historialItemsOmitidos =>
      'Algunos productos ya no están disponibles y se omitieron';

  @override
  String get perfilTitulo => 'Mi perfil';

  @override
  String get perfilCerrarSesion => 'Cerrar sesión';

  @override
  String get perfilCerrarSesionConfirm => '¿Seguro que quieres cerrar sesión?';

  @override
  String get perfilDirecciones => 'Mis direcciones';

  @override
  String get direccionEtiqueta => 'Etiqueta (Casa, Trabajo)';

  @override
  String get direccionTexto => 'Dirección';

  @override
  String get direccionReferencia => 'Referencia (opcional)';

  @override
  String get direccionGuardar => 'Guardar dirección';

  @override
  String get direccionEliminar => 'Eliminar';

  @override
  String get direccionVacio => 'No tienes direcciones guardadas';

  @override
  String get direccionNueva => 'Nueva dirección';

  @override
  String get direccionEditar => 'Editar dirección';

  @override
  String get direccionMapaSinKey =>
      'Mapa disponible al configurar API key. Ajusta las coordenadas manualmente.';

  @override
  String get panelPedidosTitulo => 'Pedidos entrantes';

  @override
  String get panelAceptar => 'Aceptar';

  @override
  String get panelRechazar => 'Rechazar';

  @override
  String get panelConfirmarAceptar => '¿Aceptar este pedido?';

  @override
  String get panelConfirmarRechazar =>
      '¿Rechazar este pedido? El cliente será notificado.';

  @override
  String get panelTiempoEstimado => 'Tiempo estimado';

  @override
  String panelTiempoExtra(int min) {
    return '+$min min';
  }

  @override
  String get panelPedidosVacio => 'No hay pedidos pendientes';

  @override
  String get panelPedidosVacioSubtitulo => 'Los nuevos pedidos aparecerán aquí';

  @override
  String get panelNuevoPedidoNotif => '¡Nuevo pedido!';

  @override
  String panelNuevoPedidoCuerpo(String cliente, String total) {
    return 'Pedido de $cliente por $total';
  }

  @override
  String get panelMenuTitulo => 'Mi menú';

  @override
  String get panelNuevoProducto => 'Nuevo producto';

  @override
  String get panelProductoNombre => 'Nombre del producto';

  @override
  String get panelProductoDescripcion => 'Descripción (opcional)';

  @override
  String get panelProductoPrecio => 'Precio (S/)';

  @override
  String get panelProductoSeccion => 'Sección del menú';

  @override
  String get panelProductoDisponible => 'Disponible';

  @override
  String get panelProductoImagen => 'Imagen del producto';

  @override
  String get panelProductoElegirImagen => 'Elegir imagen';

  @override
  String get panelGuardar => 'Guardar';

  @override
  String get panelEliminar => 'Eliminar producto';

  @override
  String get panelEliminarConfirm =>
      '¿Eliminar este producto? Esta acción no se puede deshacer.';

  @override
  String get panelMenuVacio => 'Aún no tienes productos';

  @override
  String get panelMenuVacioSubtitulo => 'Agrega tu primer producto al menú';

  @override
  String get panelDashboardTitulo => 'Ventas de hoy';

  @override
  String get panelVentasTotal => 'Vendido hoy';

  @override
  String get panelPedidosCount => 'Pedidos';

  @override
  String get panelTicketPromedio => 'Ticket promedio';

  @override
  String get panelUltimosPedidos => 'Últimos pedidos del día';

  @override
  String get navExplorar => 'Explorar';

  @override
  String get navPedidos => 'Pedidos';

  @override
  String get navPerfil => 'Perfil';

  @override
  String get navMenu => 'Menú';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get errorGenerico => 'Algo salió mal. Intenta de nuevo';

  @override
  String get errorSinConexion => 'Sin conexión a internet';

  @override
  String get errorReintentar => 'Reintentar';

  @override
  String get comunAceptar => 'Aceptar';

  @override
  String get comunCancelar => 'Cancelar';

  @override
  String get comunSi => 'Sí';

  @override
  String get comunNo => 'No';

  @override
  String get comunCerrar => 'Cerrar';
}
