import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Ligerito'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In es, this message translates to:
  /// **'Tu pedido, al toque.'**
  String get tagline;

  /// No description provided for @loginTitulo.
  ///
  /// In es, this message translates to:
  /// **'¡Qué bueno verte!'**
  String get loginTitulo;

  /// No description provided for @loginSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Ingresa para pedir tu favorito'**
  String get loginSubtitulo;

  /// No description provided for @loginTelefono.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get loginTelefono;

  /// No description provided for @loginPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPassword;

  /// No description provided for @loginBoton.
  ///
  /// In es, this message translates to:
  /// **'Ingresar'**
  String get loginBoton;

  /// No description provided for @loginSinCuenta.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Regístrate'**
  String get loginSinCuenta;

  /// No description provided for @loginOlvidaste.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get loginOlvidaste;

  /// No description provided for @loginErrorCredenciales.
  ///
  /// In es, this message translates to:
  /// **'Teléfono o contraseña incorrectos'**
  String get loginErrorCredenciales;

  /// No description provided for @registroTitulo.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get registroTitulo;

  /// No description provided for @registroNombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get registroNombre;

  /// No description provided for @registroEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo (opcional)'**
  String get registroEmail;

  /// No description provided for @registroBoton.
  ///
  /// In es, this message translates to:
  /// **'Registrarme'**
  String get registroBoton;

  /// No description provided for @registroExito.
  ///
  /// In es, this message translates to:
  /// **'¡Listo! Ya eres parte de Ligerito'**
  String get registroExito;

  /// No description provided for @recuperarTitulo.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get recuperarTitulo;

  /// No description provided for @recuperarBoton.
  ///
  /// In es, this message translates to:
  /// **'Enviar enlace'**
  String get recuperarBoton;

  /// No description provided for @recuperarMensaje.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos instrucciones a tu correo o SMS'**
  String get recuperarMensaje;

  /// No description provided for @homeTitulo.
  ///
  /// In es, this message translates to:
  /// **'¿Qué se te antoja hoy?'**
  String get homeTitulo;

  /// No description provided for @homeBuscarHint.
  ///
  /// In es, this message translates to:
  /// **'Busca pollerías, farmacias...'**
  String get homeBuscarHint;

  /// No description provided for @homeVacioTitulo.
  ///
  /// In es, this message translates to:
  /// **'Ningún negocio cerca abierto por ahora'**
  String get homeVacioTitulo;

  /// No description provided for @homeVacioSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Intenta con otra categoría o vuelve pronto'**
  String get homeVacioSubtitulo;

  /// No description provided for @categoriaTodos.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get categoriaTodos;

  /// No description provided for @categoriaRestaurante.
  ///
  /// In es, this message translates to:
  /// **'Restaurantes'**
  String get categoriaRestaurante;

  /// No description provided for @categoriaFarmacia.
  ///
  /// In es, this message translates to:
  /// **'Farmacias'**
  String get categoriaFarmacia;

  /// No description provided for @categoriaMercado.
  ///
  /// In es, this message translates to:
  /// **'Mercados'**
  String get categoriaMercado;

  /// No description provided for @categoriaFerreteria.
  ///
  /// In es, this message translates to:
  /// **'Ferreterías'**
  String get categoriaFerreteria;

  /// No description provided for @negocioAbierto.
  ///
  /// In es, this message translates to:
  /// **'Abierto'**
  String get negocioAbierto;

  /// No description provided for @negocioCerrado.
  ///
  /// In es, this message translates to:
  /// **'Cerrado'**
  String get negocioCerrado;

  /// No description provided for @negocioTiempo.
  ///
  /// In es, this message translates to:
  /// **'~{min} min'**
  String negocioTiempo(int min);

  /// No description provided for @negocioEnvio.
  ///
  /// In es, this message translates to:
  /// **'Envío {costo}'**
  String negocioEnvio(String costo);

  /// No description provided for @negocioPedidoMinimo.
  ///
  /// In es, this message translates to:
  /// **'Mínimo {monto}'**
  String negocioPedidoMinimo(String monto);

  /// No description provided for @detalleAgregar.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get detalleAgregar;

  /// No description provided for @detalleNotasHint.
  ///
  /// In es, this message translates to:
  /// **'Notas (ej. sin cebolla)'**
  String get detalleNotasHint;

  /// No description provided for @detalleAgregadoSnack.
  ///
  /// In es, this message translates to:
  /// **'Agregado a tu pedido'**
  String get detalleAgregadoSnack;

  /// No description provided for @detalleMenuVacio.
  ///
  /// In es, this message translates to:
  /// **'Este negocio aún no tiene productos'**
  String get detalleMenuVacio;

  /// No description provided for @carritoTitulo.
  ///
  /// In es, this message translates to:
  /// **'Tu pedido'**
  String get carritoTitulo;

  /// No description provided for @carritoVacio.
  ///
  /// In es, this message translates to:
  /// **'Tu carrito está vacío'**
  String get carritoVacio;

  /// No description provided for @carritoVacioSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Agrega algo rico de un negocio'**
  String get carritoVacioSubtitulo;

  /// No description provided for @carritoConflictoTitulo.
  ///
  /// In es, this message translates to:
  /// **'¿Cambiar de negocio?'**
  String get carritoConflictoTitulo;

  /// No description provided for @carritoConflictoMensaje.
  ///
  /// In es, this message translates to:
  /// **'Tu carrito tiene productos de {negocio}. Solo puedes pedir de un negocio a la vez.'**
  String carritoConflictoMensaje(String negocio);

  /// No description provided for @carritoConflictoConfirmar.
  ///
  /// In es, this message translates to:
  /// **'Vaciar y agregar'**
  String get carritoConflictoConfirmar;

  /// No description provided for @carritoContinuar.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get carritoContinuar;

  /// No description provided for @carritoMinimoNoAlcanzado.
  ///
  /// In es, this message translates to:
  /// **'Te falta {monto} para el pedido mínimo'**
  String carritoMinimoNoAlcanzado(String monto);

  /// No description provided for @carritoSubtotal.
  ///
  /// In es, this message translates to:
  /// **'Subtotal'**
  String get carritoSubtotal;

  /// No description provided for @carritoEnvio.
  ///
  /// In es, this message translates to:
  /// **'Costo de envío'**
  String get carritoEnvio;

  /// No description provided for @carritoTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get carritoTotal;

  /// No description provided for @checkoutTitulo.
  ///
  /// In es, this message translates to:
  /// **'Confirmar pedido'**
  String get checkoutTitulo;

  /// No description provided for @checkoutDireccion.
  ///
  /// In es, this message translates to:
  /// **'Dirección de entrega'**
  String get checkoutDireccion;

  /// No description provided for @checkoutMetodoPago.
  ///
  /// In es, this message translates to:
  /// **'Método de pago'**
  String get checkoutMetodoPago;

  /// No description provided for @checkoutYapeInstruccion.
  ///
  /// In es, this message translates to:
  /// **'Yapea al {numero} y adjunta tu captura'**
  String checkoutYapeInstruccion(String numero);

  /// No description provided for @checkoutPlinInstruccion.
  ///
  /// In es, this message translates to:
  /// **'Haz Plin al {numero} y adjunta tu captura'**
  String checkoutPlinInstruccion(String numero);

  /// No description provided for @checkoutAdjuntarCaptura.
  ///
  /// In es, this message translates to:
  /// **'Adjuntar captura (opcional)'**
  String get checkoutAdjuntarCaptura;

  /// No description provided for @checkoutCapturaAdjunta.
  ///
  /// In es, this message translates to:
  /// **'Captura adjunta'**
  String get checkoutCapturaAdjunta;

  /// No description provided for @checkoutConfirmar.
  ///
  /// In es, this message translates to:
  /// **'Confirmar pedido'**
  String get checkoutConfirmar;

  /// No description provided for @checkoutEfectivoNota.
  ///
  /// In es, this message translates to:
  /// **'Paga en efectivo al recibir'**
  String get checkoutEfectivoNota;

  /// No description provided for @checkoutSinDireccion.
  ///
  /// In es, this message translates to:
  /// **'Elige una dirección de entrega'**
  String get checkoutSinDireccion;

  /// No description provided for @pedidoConfirmadoTitulo.
  ///
  /// In es, this message translates to:
  /// **'¡Pedido confirmado!'**
  String get pedidoConfirmadoTitulo;

  /// No description provided for @pedidoConfirmadoMensaje.
  ///
  /// In es, this message translates to:
  /// **'Tu pedido #{numero} ya está con el negocio'**
  String pedidoConfirmadoMensaje(String numero);

  /// No description provided for @pedidoVerSeguimiento.
  ///
  /// In es, this message translates to:
  /// **'Ver seguimiento'**
  String get pedidoVerSeguimiento;

  /// No description provided for @seguimientoTitulo.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento'**
  String get seguimientoTitulo;

  /// No description provided for @seguimientoCasiLlega.
  ///
  /// In es, this message translates to:
  /// **'¡Ya casi llega, ligerito!'**
  String get seguimientoCasiLlega;

  /// No description provided for @seguimientoContactar.
  ///
  /// In es, this message translates to:
  /// **'Contactar al negocio'**
  String get seguimientoContactar;

  /// No description provided for @seguimientoCanceladoBanner.
  ///
  /// In es, this message translates to:
  /// **'Este pedido fue cancelado'**
  String get seguimientoCanceladoBanner;

  /// No description provided for @seguimientoWhatsAppMensaje.
  ///
  /// In es, this message translates to:
  /// **'Hola, consulto por mi pedido #{numero} en Ligerito'**
  String seguimientoWhatsAppMensaje(String numero);

  /// No description provided for @estadoPendiente.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get estadoPendiente;

  /// No description provided for @estadoConfirmado.
  ///
  /// In es, this message translates to:
  /// **'Confirmado'**
  String get estadoConfirmado;

  /// No description provided for @estadoPreparando.
  ///
  /// In es, this message translates to:
  /// **'Preparando'**
  String get estadoPreparando;

  /// No description provided for @estadoEnCamino.
  ///
  /// In es, this message translates to:
  /// **'En camino'**
  String get estadoEnCamino;

  /// No description provided for @estadoEntregado.
  ///
  /// In es, this message translates to:
  /// **'Entregado'**
  String get estadoEntregado;

  /// No description provided for @estadoCancelado.
  ///
  /// In es, this message translates to:
  /// **'Cancelado'**
  String get estadoCancelado;

  /// No description provided for @historialTitulo.
  ///
  /// In es, this message translates to:
  /// **'Mis pedidos'**
  String get historialTitulo;

  /// No description provided for @historialVacio.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes pedidos'**
  String get historialVacio;

  /// No description provided for @historialVacioSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Tu primer pedido te espera, ligerito'**
  String get historialVacioSubtitulo;

  /// No description provided for @historialRepetir.
  ///
  /// In es, this message translates to:
  /// **'Repetir pedido'**
  String get historialRepetir;

  /// No description provided for @historialItemsOmitidos.
  ///
  /// In es, this message translates to:
  /// **'Algunos productos ya no están disponibles y se omitieron'**
  String get historialItemsOmitidos;

  /// No description provided for @perfilTitulo.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get perfilTitulo;

  /// No description provided for @perfilCerrarSesion.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get perfilCerrarSesion;

  /// No description provided for @perfilCerrarSesionConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres cerrar sesión?'**
  String get perfilCerrarSesionConfirm;

  /// No description provided for @perfilDirecciones.
  ///
  /// In es, this message translates to:
  /// **'Mis direcciones'**
  String get perfilDirecciones;

  /// No description provided for @direccionEtiqueta.
  ///
  /// In es, this message translates to:
  /// **'Etiqueta (Casa, Trabajo)'**
  String get direccionEtiqueta;

  /// No description provided for @direccionTexto.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get direccionTexto;

  /// No description provided for @direccionReferencia.
  ///
  /// In es, this message translates to:
  /// **'Referencia (opcional)'**
  String get direccionReferencia;

  /// No description provided for @direccionGuardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar dirección'**
  String get direccionGuardar;

  /// No description provided for @direccionEliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get direccionEliminar;

  /// No description provided for @direccionVacio.
  ///
  /// In es, this message translates to:
  /// **'No tienes direcciones guardadas'**
  String get direccionVacio;

  /// No description provided for @direccionNueva.
  ///
  /// In es, this message translates to:
  /// **'Nueva dirección'**
  String get direccionNueva;

  /// No description provided for @direccionEditar.
  ///
  /// In es, this message translates to:
  /// **'Editar dirección'**
  String get direccionEditar;

  /// No description provided for @direccionMapaSinKey.
  ///
  /// In es, this message translates to:
  /// **'Mapa disponible al configurar API key. Ajusta las coordenadas manualmente.'**
  String get direccionMapaSinKey;

  /// No description provided for @panelPedidosTitulo.
  ///
  /// In es, this message translates to:
  /// **'Pedidos entrantes'**
  String get panelPedidosTitulo;

  /// No description provided for @panelAceptar.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get panelAceptar;

  /// No description provided for @panelRechazar.
  ///
  /// In es, this message translates to:
  /// **'Rechazar'**
  String get panelRechazar;

  /// No description provided for @panelConfirmarAceptar.
  ///
  /// In es, this message translates to:
  /// **'¿Aceptar este pedido?'**
  String get panelConfirmarAceptar;

  /// No description provided for @panelConfirmarRechazar.
  ///
  /// In es, this message translates to:
  /// **'¿Rechazar este pedido? El cliente será notificado.'**
  String get panelConfirmarRechazar;

  /// No description provided for @panelTiempoEstimado.
  ///
  /// In es, this message translates to:
  /// **'Tiempo estimado'**
  String get panelTiempoEstimado;

  /// No description provided for @panelTiempoExtra.
  ///
  /// In es, this message translates to:
  /// **'+{min} min'**
  String panelTiempoExtra(int min);

  /// No description provided for @panelPedidosVacio.
  ///
  /// In es, this message translates to:
  /// **'No hay pedidos pendientes'**
  String get panelPedidosVacio;

  /// No description provided for @panelPedidosVacioSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Los nuevos pedidos aparecerán aquí'**
  String get panelPedidosVacioSubtitulo;

  /// No description provided for @panelNuevoPedidoNotif.
  ///
  /// In es, this message translates to:
  /// **'¡Nuevo pedido!'**
  String get panelNuevoPedidoNotif;

  /// No description provided for @panelNuevoPedidoCuerpo.
  ///
  /// In es, this message translates to:
  /// **'Pedido de {cliente} por {total}'**
  String panelNuevoPedidoCuerpo(String cliente, String total);

  /// No description provided for @panelMenuTitulo.
  ///
  /// In es, this message translates to:
  /// **'Mi menú'**
  String get panelMenuTitulo;

  /// No description provided for @panelNuevoProducto.
  ///
  /// In es, this message translates to:
  /// **'Nuevo producto'**
  String get panelNuevoProducto;

  /// No description provided for @panelProductoNombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre del producto'**
  String get panelProductoNombre;

  /// No description provided for @panelProductoDescripcion.
  ///
  /// In es, this message translates to:
  /// **'Descripción (opcional)'**
  String get panelProductoDescripcion;

  /// No description provided for @panelProductoPrecio.
  ///
  /// In es, this message translates to:
  /// **'Precio (S/)'**
  String get panelProductoPrecio;

  /// No description provided for @panelProductoSeccion.
  ///
  /// In es, this message translates to:
  /// **'Sección del menú'**
  String get panelProductoSeccion;

  /// No description provided for @panelProductoDisponible.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get panelProductoDisponible;

  /// No description provided for @panelProductoImagen.
  ///
  /// In es, this message translates to:
  /// **'Imagen del producto'**
  String get panelProductoImagen;

  /// No description provided for @panelProductoElegirImagen.
  ///
  /// In es, this message translates to:
  /// **'Elegir imagen'**
  String get panelProductoElegirImagen;

  /// No description provided for @panelGuardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get panelGuardar;

  /// No description provided for @panelEliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar producto'**
  String get panelEliminar;

  /// No description provided for @panelEliminarConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este producto? Esta acción no se puede deshacer.'**
  String get panelEliminarConfirm;

  /// No description provided for @panelMenuVacio.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes productos'**
  String get panelMenuVacio;

  /// No description provided for @panelMenuVacioSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Agrega tu primer producto al menú'**
  String get panelMenuVacioSubtitulo;

  /// No description provided for @panelDashboardTitulo.
  ///
  /// In es, this message translates to:
  /// **'Ventas de hoy'**
  String get panelDashboardTitulo;

  /// No description provided for @panelVentasTotal.
  ///
  /// In es, this message translates to:
  /// **'Vendido hoy'**
  String get panelVentasTotal;

  /// No description provided for @panelPedidosCount.
  ///
  /// In es, this message translates to:
  /// **'Pedidos'**
  String get panelPedidosCount;

  /// No description provided for @panelTicketPromedio.
  ///
  /// In es, this message translates to:
  /// **'Ticket promedio'**
  String get panelTicketPromedio;

  /// No description provided for @panelUltimosPedidos.
  ///
  /// In es, this message translates to:
  /// **'Últimos pedidos del día'**
  String get panelUltimosPedidos;

  /// No description provided for @navExplorar.
  ///
  /// In es, this message translates to:
  /// **'Explorar'**
  String get navExplorar;

  /// No description provided for @navPedidos.
  ///
  /// In es, this message translates to:
  /// **'Pedidos'**
  String get navPedidos;

  /// No description provided for @navPerfil.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navPerfil;

  /// No description provided for @navMenu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get navMenu;

  /// No description provided for @navDashboard.
  ///
  /// In es, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @errorGenerico.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal. Intenta de nuevo'**
  String get errorGenerico;

  /// No description provided for @errorSinConexion.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión a internet'**
  String get errorSinConexion;

  /// No description provided for @errorReintentar.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get errorReintentar;

  /// No description provided for @comunAceptar.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get comunAceptar;

  /// No description provided for @comunCancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get comunCancelar;

  /// No description provided for @comunSi.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get comunSi;

  /// No description provided for @comunNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get comunNo;

  /// No description provided for @comunCerrar.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get comunCerrar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
