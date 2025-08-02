// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get pageIdentificationEnterYourCode => 'Ingrese el código';

  @override
  String get pageIdentificationEnterTheCompanyCode =>
      'Ingrese el código de empresa que le\nhan asignado';

  @override
  String get pageLoginAskForLocationWhenInUsePermission =>
      'Lightdata es una aplicación que recopila datos de ubicación para habilitar el posicionamiento de los paquetes y el armado de rutas posibles de las entregas, incluso cuando la aplicación está cerrada o no está en uso.';

  @override
  String get pageLoginAskForLocationAlwaysPermission =>
      'Lightdata es una aplicación que recolectará la ubicación del celular en segundo plano para ofrecer una mejor herramienta de trabajo. De esta manera, se sabrá la posición del paquete en todo momento.';

  @override
  String get pageLoginAskForPermissions =>
      'Lightdata recopila datos de ubicación para:\n- Permitir la ubicación de los envíos y el enrutamiento de las entregas.\n- Proporcionar una mejor herramienta de trabajo al rastrear la ubicación de los envíos en tiempo real.\n\nEstos datos se recopilan incluso cuando la aplicación está cerrada o no se está utilizando.(background)\n\nObtén más información sobre cómo usamos tus datos de ubicación en nuestra';

  @override
  String get pageLoginBadCredentials => 'Credenciales incorrectas';

  @override
  String get pageLoginProCourrierError =>
      'Tenemos otra app para Pro Courrier, por favor descargala desde la play store';

  @override
  String get pageHomeTitle => 'Paquetes de ';

  @override
  String get pageHomeOptionShipmentsDeliveredToday =>
      'Paquetes\nentregados hoy';

  @override
  String get pageHomeOptionTodaysAssignedShipments => 'Paquetes\nasignados hoy';

  @override
  String get pageHomeOptionShipmentsOnTheWay => 'Paquetes\nen camino';

  @override
  String get pageHomeOptionClosedShipments => 'Paquetes\ncerrados';

  @override
  String get pageHomeOptionPendingShipments => 'Paquetes\npendientes';

  @override
  String get pageHomeStartRoute => 'Comenzar ruta';

  @override
  String get pageHomeFinishRoute => 'Finalizar ruta';

  @override
  String get pageQrScanInvalidQR => 'QR inválido';

  @override
  String get pageQrMenuTitle => 'Selecciona un lector de QR';

  @override
  String get pageQrMenuOptionToProcessingPlant => 'A planta';

  @override
  String get pageQrMenuOptionCollect => 'Colecta';

  @override
  String get pageQrScanSuccess => 'Carga realizada con éxito';

  @override
  String get pageQrMenuOptionReadQr => 'Leer QR';

  @override
  String get pageQrMenuOptionAssign => 'Asignación';

  @override
  String get pageQrMenuOptionCrossDocking => 'Cross Docking';

  @override
  String get pageQrMenuOptionShipmentInformation => 'Información\n del envío';

  @override
  String get pageQrMenuOptionEnterFlex => 'Ingresar flex';

  @override
  String get pageQrCollectCollectedTodayByMe => 'Retirados hoy por mi';

  @override
  String get pageQrProccessingPlantTodayForMeInTheDay => 'Hoy por mi en el día';

  @override
  String get pageQrProccessingPlantCustomerToday => 'Hoy del cliente';

  @override
  String pageQrProccessingPlantMissings(String clientName) {
    return 'Faltantes a planta de ingreso hoy ($clientName)';
  }

  @override
  String get pageQrReadNow => 'Leidos ahora';

  @override
  String get pageQrScanTheQR => 'Escanea el QR';

  @override
  String get pageQrDeliveryArea => 'Zona de entrega';

  @override
  String get pageQrReadQRDni => 'Leer QR DNI';

  @override
  String get pageQrSaveVisit => 'Guardar visita';

  @override
  String get pageQrRegisterVisit => 'Registrar visita';

  @override
  String get pageQrSelfAssign => 'Auto-asignar';

  @override
  String get pageQrCollectTotalToCollectClient => 'Total a retirar cliente';

  @override
  String get pageQrCollectToCollectToday => 'A colectar hoy';

  @override
  String get pageQrCollectCollectedToday => 'Colectados hoy';

  @override
  String get pageFiltersApplyFilters => 'Aplicar filtros';

  @override
  String get pageFiltersCleanFilters => 'Limpiar filtros';

  @override
  String get pageFiltersRecipientName => 'Nombre Destinatario';

  @override
  String get pageFiltersClientName => 'Nombre cliente';

  @override
  String get pageShipmentProductsOrderedAmount => 'Cantidad pedida';

  @override
  String get pageShipmentProductsLastReading => 'Última lectura';

  @override
  String get pageShipmentAssignmentAmountOfShipmentsAssignedToday =>
      'Paquetes asignados hoy';

  @override
  String get pageShipmentAssignmentChooseADriver => 'Elegir un chofer';

  @override
  String get pageMapsGenerateRoutes => 'Generar rutas';

  @override
  String get pageMapsGeolocate => 'Geolocalizar';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsGeolocated =>
      'Total de paquetes geolocalizados';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsWithoutGeolocation =>
      'Total de paquetes sin geolocalizar';

  @override
  String get pageMapsCardDataItemDistanceInKm => 'Cantidad de kilometros';

  @override
  String get pageMapsCardDataItemDistanceTime => 'Tiempo de distancia';

  @override
  String get pageMapsDepot => 'Depósito';

  @override
  String get pageMapsLastShipment => 'Último envío';

  @override
  String get pageMapsMyCurrentLocation => 'Mi ubicación actual';

  @override
  String get pageMapsShipmentsWithoutGeolocate => 'Hay envíos sin geolocalizar';

  @override
  String get pageMapsAlertYouHaveToSelectAShipment =>
      'Tenes que seleccionar uno de los envíos para generar la ruta.';

  @override
  String get pageMapsAvoidHighways => 'Evitar autopistas';

  @override
  String get pageMapsAvoidTollways => 'Evitar peajes';

  @override
  String get pageMapsChooseWhereToFinish => 'Elegir donde finalizar';

  @override
  String get pageMapsChooseWhereToStart => 'Elegir donde comenzar';

  @override
  String get pageMapsSelectALocation =>
      'Tenes que seleccionar un punto en el mapa';

  @override
  String get pageMapsNoGeolocatedShipments => 'No hay envíos geolocalizados';

  @override
  String get pageMapsRouteGeneratedCorrectly => 'Ruta generada correctamente';

  @override
  String get pageProfileForgetSession => 'Olvidar todo';

  @override
  String get pageProfileProfilePicture => 'Foto de perfil';

  @override
  String get pageProfileDeletePictureConfirmation =>
      '¿Estás seguro de que queres eliminar esta foto?';

  @override
  String get pageProfileIntegrationsLinks => 'Links integraciones';

  @override
  String get pageProfileAreYouSureThatYouWantToDeleteCache =>
      '¿Estás seguro de que queres eliminar el caché?';

  @override
  String get pageProfileClearCache => 'Limpiar caché';

  @override
  String get pageProfileProfilePictureChangedSuccessfully =>
      'Foto de perfil cambiada con éxito';

  @override
  String get pageProfileChangePassword => 'Cambiar contraseña';

  @override
  String get pageProfileSuccessEditingPersonalData =>
      'Datos personales editados con éxito';

  @override
  String get pageProfileChangeIcon => 'Cambiar icono';

  @override
  String get pageRegisterVisitAddObservations => 'Agregar observaciones';

  @override
  String get pageRegisterVisitDNIOfTheRecipient => 'DNI Recibe';

  @override
  String get pageRegisterVisitRUTOfTheRecipient => 'RUT Recibe';

  @override
  String get pageRegisterVisitCCOfTheRecipient => 'C.C. Recibe';

  @override
  String get pageRegisterVisitNameOfTheRecipient => 'Nombre quien recibe';

  @override
  String get pageRegisterVisitRegisterVisit => 'Registrar Visita';

  @override
  String get pageRegisterVisitImageLimitAlert =>
      'Has alcanzado el límite de imágenes';

  @override
  String get pageRegisterVisitSuccess => 'Visita registrada con éxito';

  @override
  String get pageRegisterVisitUploadingImages => 'Subiendo imágenes...';

  @override
  String get pageRegisterVisitErrorRequiredImage =>
      'Es necesario agregar una imagen';

  @override
  String get pageShipmentDetailsWithoutObservations => 'Sin observaciones';

  @override
  String get pageShipmentDetailsIdShipment => 'ID envío';

  @override
  String get pageShipmentDetailsIdSale => 'ID venta';

  @override
  String get pageShipmentDetailsTotalToClaim => 'Total a cobrar';

  @override
  String get pageShipmentDetailsWhoRecibeTheShipment =>
      'Recibe el paquete titular de la compra';

  @override
  String get pageShipmentDetailsNoLocationOfShipment =>
      'No se ha proporcionado la ubicación';

  @override
  String get pageShipmentListTotalShipments => 'Total paquetes visualizados';

  @override
  String get pageShipmentListNoShipmentsAvailable =>
      'No hay paquetes disponibles';

  @override
  String get pageShipmentListTheShipmentDoesntHavePhoneNumber =>
      'Este envío no tiene un numero de telefono asignado';

  @override
  String get pageShipmentListShipmentProximoAEntregar => 'Próximo a entregar';

  @override
  String get pageShipmentListTodaysPackagesAreNotBeingShown =>
      'No se están mostrando paquetes de hoy';

  @override
  String get pageAccountsSellerId => 'Seller Id';

  @override
  String get pageSettlementsNoSettlements => 'No hay liquidaciones disponibles';

  @override
  String get pageSettlementsShipmentAddress => 'Dirección envío';

  @override
  String get pageSettlementsWhoLiquidate => 'Quien liquido';

  @override
  String get pageSettlementsLiquidateDate => 'Fecha liquidación';

  @override
  String get pageSettlementsNoShipmentAvailable => 'No hay envíos disponibles';

  @override
  String get pageSettlementsNumbersOfTrips => 'Cantidad de viajes';

  @override
  String get pageAppConfiguration => 'Configuración de la aplicación';

  @override
  String get pageAppConfigurationDefaultRegisterVisitStates =>
      'Estados por defecto para registrar visitas';

  @override
  String get pageAppConfigurationChangeGeoDriversHours =>
      'Cambiar horas de geolocalización de choferes';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursStartHour =>
      'Hora de inicio';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursEndHour => 'Hora de fin';

  @override
  String get pageAppConfigurationCheckPermissions => 'Verificar permisos';

  @override
  String get pageCheckPermissionsAlreadyAllowed =>
      'Los permisos ya están otorgados';

  @override
  String get pageCheckPermissionsAlreadyAllowedDescription =>
      'Los permisos ya han sido otorgados';

  @override
  String get pageAppConfigurationCheckPermissionsAllowed =>
      'Permisos otorgados correctamente';

  @override
  String get pageCheckPermissionsAllowedDescription =>
      'Los permisos han sido otorgados';

  @override
  String get pageAppConfigurationCheckPermissionsDenied => 'Permisos denegados';

  @override
  String get pageAppConfigurationNewWhatsappMessages =>
      'Nuevos mensajes de Whatsapp disponibles';

  @override
  String get pageCollectCurrentRoute => 'Ruta actual';

  @override
  String get pageCollectToCollect => 'Colectar';

  @override
  String get pageCollectCollectList => 'Listado de colectas';

  @override
  String get pageCollectSettlementList => 'Listado de liquidaciones';

  @override
  String get pageCollectShipmentList => 'Listado de envíos';

  @override
  String get pageCollectCollectDetails => 'Detalles de la colecta';

  @override
  String get pageCollectSellerDetails => 'Detalles del vendedor';

  @override
  String get pageCollectSettlementDate => 'Fecha de liquidación';

  @override
  String get pageCollectSettlementRange => 'Rango de liquidación';

  @override
  String get pageCollectSettlementDetails => 'Detalles de liquidación';

  @override
  String get pageCollectTotalToCollect => 'Total colectas';

  @override
  String get pageCollectTotalClients => 'Total clientes';

  @override
  String get pageCollectTotalClientsToCollect => 'Total de clientes a colectar';

  @override
  String get pageCollectNotEveryClientIsGeolocalized =>
      'No todos los clientes están geolocalizados';

  @override
  String get bottomNavigationBarOptionHome => 'Inicio';

  @override
  String get bottomNavigationBarOptionShipments => 'Paquetes';

  @override
  String get bottomNavigationBarOptionQR => 'QR';

  @override
  String get bottomNavigationBarOptionMaps => 'Mapas';

  @override
  String get bottomNavigationBarOptionProfile => 'Perfil';

  @override
  String get bottomNavigationBarOptionSettings => 'Configuración';

  @override
  String get bottomNavigationBarOptionMySettlements => 'Mis liquidaciones';

  @override
  String get bottomNavigationBarOptionLogout => 'Cerrar sesión';

  @override
  String get stateCollected => 'Retirado';

  @override
  String get stateAtProcessingPlant => 'En planta de procesamiento';

  @override
  String get stateAtProcessingPlant2 => 'En planta de procesamiento 2';

  @override
  String get stateOnTheWay => 'En camino';

  @override
  String get stateReturningToProcessingPlant =>
      'Volviendo a la planta de procesamiento';

  @override
  String get stateDelivered => 'Entregado';

  @override
  String get stateNobody => 'Nadie en casa';

  @override
  String get stateToBeCollected => 'A retirar';

  @override
  String get stateCanceled => 'Cancelado';

  @override
  String get stateDeliveredSecondVisit => 'Entregado 2da visita';

  @override
  String get stateNobodySecondVisit => 'Nadie en casa 2da visita';

  @override
  String get stateOnTheWaySecondVisit => 'En camino 2da visita';

  @override
  String get stateOnTheWayRescheduled => 'En camino reprogramado';

  @override
  String get stateNotDelivered => 'No entregado';

  @override
  String get stateReturnedToClient => 'Devuelto al cliente';

  @override
  String get stateRejectedByClient => 'Rechazado por el comprador';

  @override
  String get stateOnTheWayThirdVisit => 'En camino 3ra visita';

  @override
  String get stateDeliveredThirdVisit => 'Entregado 3ra visita';

  @override
  String get stateNobodyThirdVisit => 'Nadie en casa 3ra visita';

  @override
  String get stateDeliveredPickupPoint => 'Entregado en punto de retiro';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languagePortuguese => 'Portugues';

  @override
  String get commonUser => 'Usuario';

  @override
  String get commonFilter => 'Filtrar';

  @override
  String get commonLogin => 'Ingresar';

  @override
  String get commonToday => 'Hoy';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonGenerate => 'Generar';

  @override
  String get commonId => 'Id';

  @override
  String get commonUbication => 'Ubicación';

  @override
  String get commonSaveImage => 'Cargar imagen';

  @override
  String get commonAddImage => 'Agregar imagen';

  @override
  String get commonDeleteImage => 'Eliminar imagen';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonUserName => 'Nombre de usuario';

  @override
  String get commonContact => 'Contacto';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonCompany => 'Empresa';

  @override
  String get commonPlan => 'Plan';

  @override
  String get commonAccept => 'Aceptar';

  @override
  String get commonDriver => 'Chofer';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonLoad => 'Cargar';

  @override
  String get commonHome => 'Inicio';

  @override
  String get commonCamera => 'Cámara';

  @override
  String get commonGallery => 'Galería';

  @override
  String get commonHistory => 'Historial';

  @override
  String get commonState => 'Estado';

  @override
  String get commonStates => 'Estados';

  @override
  String get commonLocation => 'Localidad';

  @override
  String get commonAddress => 'Dirección';

  @override
  String get commonDate => 'Fecha';

  @override
  String get commonDateFrom => 'Fecha desde';

  @override
  String get commonDateTo => 'Fecha hasta';

  @override
  String get commonObservations => 'Observaciones';

  @override
  String get commonClient => 'Cliente';

  @override
  String get commonTotal => 'Total';

  @override
  String get commonTracking => 'Seguimiento';

  @override
  String get commonSettlements => 'Liquidaciones';

  @override
  String get commonSelectADate => 'Selecciona una fecha';

  @override
  String get commonPersonalData => 'Datos personales';

  @override
  String get commonMyData => 'Mis datos';

  @override
  String get commonOn => 'On';

  @override
  String get commonOff => 'Off';

  @override
  String get commonAssign => 'Asignar';

  @override
  String get commonSKU => 'SKU';

  @override
  String get commonVariation => 'Variation';

  @override
  String get commonSource => 'Origen';

  @override
  String get commonImportant => 'Importante';

  @override
  String get commonIncorrectCode => 'Código incorrecto';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonHouse => 'Casa';

  @override
  String get commonSelect => 'Seleccionar';

  @override
  String get commonSync => 'Sincronizado';

  @override
  String get commonWithoutSync => 'No sincronizado';

  @override
  String get commonNumber => 'Número';

  @override
  String get commonAdd => 'Agregar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSaved => 'Guardado';

  @override
  String get commonFeatNotAvailableTitle => 'Funcionalidad no disponible';

  @override
  String get commonFeatNotAvailableDescription =>
      'Esta funcionalidad no se encuentra disponible en esta versión de la aplicación';

  @override
  String get commonInformationSavedSuccessfully =>
      'Su información se ha guardado correctamente';

  @override
  String get commonOops => 'Ups';

  @override
  String get commonNoMovements => 'No hay movimientos';

  @override
  String get commonCP => 'CP';

  @override
  String get commonAccounts => 'Cuentas';

  @override
  String get commonHi => 'Hola';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonOk => 'Ok';

  @override
  String get commonAdmitted => 'Ingresados';

  @override
  String get commonSeconds => 'Segundos';

  @override
  String get commonError => 'Error';

  @override
  String get commonIUnderstand => 'Entiendo';

  @override
  String get commonPassword => 'Contraseña';

  @override
  String get commonOf => 'de';

  @override
  String get commonNoInternet => 'No hay conexión a internet';

  @override
  String get commonNoAvailableWithoutInternet =>
      'Esta funcionalidad no está disponible sin conexión a internet. Por favor, conéctese a una red y vuelva a intentarlo.';

  @override
  String get commonErrorText =>
      'Ha ocurrido un error, intente eliminando el cache de la aplicación y iniciando sesión nuevamente, si el problema persiste contacte a soporte.';

  @override
  String get commonShipment => 'Envío';

  @override
  String get commonVersion => 'Versión';

  @override
  String get commonApp => 'App';

  @override
  String get commonCurrentPassword => 'Contraseña actual';

  @override
  String get commonNewPassword => 'Nueva contraseña';

  @override
  String get commonRepeatNewPassword => 'Repetir nueva contraseña';

  @override
  String get commonSuccess => 'Éxito';

  @override
  String get commonChange => 'Cambiar';

  @override
  String get commonBranch => 'Sucursal';

  @override
  String get commonNow => 'Ahora';

  @override
  String get commonNotifications => 'Notificaciones';

  @override
  String get commonCollect => 'Colecta';

  @override
  String get commonStart => 'Iniciar';

  @override
  String get commonSavedWithoutConnection => 'Guardado sin conexión';

  @override
  String get commonRefresh => 'Refrescar';

  @override
  String get commonUnAssign => 'Desasignar';

  @override
  String commonSynchronizing(int current, int total) {
    return 'Sincronizando $current de $total';
  }

  @override
  String get commonWhitoutInformation => 'Sin información';

  @override
  String get commonRegenerate => 'Regenerar';

  @override
  String get commonNoShipmentsAvailable => 'No hay envíos disponibles';

  @override
  String get commonAmountToCharge => 'Monto a cobrar';

  @override
  String get commonAllowPermissions => 'Permitir permisos';
}
