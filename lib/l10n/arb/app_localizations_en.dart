// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get pageIdentificationEnterYourCode => 'Enter the code';

  @override
  String get pageIdentificationEnterTheCompanyCode =>
      'Enter the company code\nassigned to you';

  @override
  String get pageLoginAskForLocationWhenInUsePermission =>
      'Lightdata app collects location data to enable positioning of shipments and possible routing of deliveries even when the app is closed or not in use.';

  @override
  String get pageLoginAskForLocationAlwaysPermission =>
      'Lightdata is an application that will collect the cell phone location in the background to offer a better work tool. This way, the position of the shipment will be known at all times.';

  @override
  String get pageLoginAskForPermissions =>
      'Lightdata app collects location data to:\n- Enable positioning of shipments and routing of deliveries.\n- Provide a better work tool by tracking the shipment location in real time.\n\nThis data is collected even when the app is closed or not in use.(background)\n\nLearn more about how we use your location data in our';

  @override
  String get pageLoginBadCredentials => 'Bad credentials';

  @override
  String get pageLoginProCourrierError =>
      'We have another app for Pro Courrier, please download it from the store.';

  @override
  String get pageHomeTitle => 'Shipments from ';

  @override
  String get pageHomeOptionShipmentsDeliveredToday =>
      'Shipments\n delivered today';

  @override
  String get pageHomeOptionTodaysAssignedShipments =>
      'Todays\nassigned shipments';

  @override
  String get pageHomeOptionShipmentsOnTheWay => 'On the way';

  @override
  String get pageHomeOptionClosedShipments => 'Closed\nshipments';

  @override
  String get pageHomeOptionPendingShipments => 'Pending\nshipments';

  @override
  String get pageHomeStartRoute => 'Start route';

  @override
  String get pageHomeFinishRoute => 'Finish route';

  @override
  String get pageQrScanInvalidQR => 'QR code not valid';

  @override
  String get pageQrMenuTitle => 'Select a QR reader';

  @override
  String get pageQrMenuOptionToProcessingPlant => 'To processing\n plant';

  @override
  String get pageQrMenuOptionCollect => 'Collect';

  @override
  String get pageQrScanSuccess => 'Success scanning QR';

  @override
  String get pageQrMenuOptionReadQr => 'Read QR';

  @override
  String get pageQrMenuOptionAssign => 'Assign';

  @override
  String get pageQrMenuOptionCrossDocking => 'Cross Docking';

  @override
  String get pageQrMenuOptionShipmentInformation => 'Shipment\n information';

  @override
  String get pageQrMenuOptionEnterFlex => 'Enter flex';

  @override
  String get pageQrCollectCollectedTodayByMe => 'Retired today by me';

  @override
  String get pageQrProccessingPlantTodayForMeInTheDay =>
      'Today for me in the day';

  @override
  String get pageQrProccessingPlantCustomerToday => 'Customer today';

  @override
  String pageQrProccessingPlantMissings(String clientName) {
    return 'Missings at the entrance floor today ($clientName)';
  }

  @override
  String get pageQrReadNow => 'Read now';

  @override
  String get pageQrScanTheQR => 'Scan the QR';

  @override
  String get pageQrDeliveryArea => 'Delivery area';

  @override
  String get pageQrReadQRDni => 'Read QR DNI';

  @override
  String get pageQrSaveVisit => 'Save visit';

  @override
  String get pageQrRegisterVisit => 'Register visit';

  @override
  String get pageQrSelfAssign => 'Self-assign';

  @override
  String get pageQrCollectTotalToCollectClient => 'Total to withdraw customer';

  @override
  String get pageQrCollectToCollectToday => 'To collect today';

  @override
  String get pageQrCollectCollectedToday => 'Collected today';

  @override
  String get pageFiltersApplyFilters => 'Apply filters';

  @override
  String get pageFiltersCleanFilters => 'Clean filters';

  @override
  String get pageFiltersRecipientName => 'Recipient name';

  @override
  String get pageFiltersClientName => 'Client name';

  @override
  String get pageShipmentProductsOrderedAmount => 'Orderer amount';

  @override
  String get pageShipmentProductsLastReading => 'Last reading';

  @override
  String get pageShipmentAssignmentAmountOfShipmentsAssignedToday =>
      'Shipments assigned today';

  @override
  String get pageShipmentAssignmentChooseADriver => 'Choose a driver';

  @override
  String get pageMapsGenerateRoutes => 'Generate routes';

  @override
  String get pageMapsGeolocate => 'Geolocate';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsGeolocated =>
      'Total of shipments geolocated';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsWithoutGeolocation =>
      'Total of shipments without geolocation';

  @override
  String get pageMapsCardDataItemDistanceInKm => 'Distance in kilometers';

  @override
  String get pageMapsCardDataItemDistanceTime => 'Distance time';

  @override
  String get pageMapsDepot => 'Depot';

  @override
  String get pageMapsLastShipment => 'Last shipment';

  @override
  String get pageMapsMyCurrentLocation => 'My current location';

  @override
  String get pageMapsShipmentsWithoutGeolocate => 'Shipments without geolocate';

  @override
  String get pageMapsAlertYouHaveToSelectAShipment =>
      'You have to select one of the shipments to generate the route.';

  @override
  String get pageMapsAvoidHighways => 'Avoid highways';

  @override
  String get pageMapsAvoidTollways => 'Avoid tollways';

  @override
  String get pageMapsChooseWhereToFinish => 'Choose where to finish';

  @override
  String get pageMapsChooseWhereToStart => 'Choose where to start';

  @override
  String get pageMapsSelectALocation => 'Select a location';

  @override
  String get pageMapsNoGeolocatedShipments => 'No geolocated shipments';

  @override
  String get pageMapsRouteGeneratedCorrectly => 'Route generated correctly';

  @override
  String get pageProfileForgetSession => 'Forget session';

  @override
  String get pageProfileProfilePicture => 'Profile picture';

  @override
  String get pageProfileDeletePictureConfirmation =>
      'Are you sure you want to delete this picture?';

  @override
  String get pageProfileIntegrationsLinks => 'Integrations links';

  @override
  String get pageProfileAreYouSureThatYouWantToDeleteCache =>
      'Are you sure that you want to delete cache?';

  @override
  String get pageProfileClearCache => 'Clear cache';

  @override
  String get pageProfileProfilePictureChangedSuccessfully =>
      'Profile picture changed successfully';

  @override
  String get pageProfileChangePassword => 'Change password';

  @override
  String get pageProfileSuccessEditingPersonalData =>
      'Success editing personal data';

  @override
  String get pageProfileChangeIcon => 'Change icon';

  @override
  String get pageRegisterVisitAddObservations => 'Add observations';

  @override
  String get pageRegisterVisitDNIOfTheRecipient => 'Receiver\'s DNI';

  @override
  String get pageRegisterVisitRUTOfTheRecipient => 'Receiver\'s RUT';

  @override
  String get pageRegisterVisitCCOfTheRecipient => 'Receiver\'s C.C.';

  @override
  String get pageRegisterVisitNameOfTheRecipient => 'Name of the recipient';

  @override
  String get pageRegisterVisitRegisterVisit => 'Register visit';

  @override
  String get pageRegisterVisitImageLimitAlert =>
      'You have reached the image limit';

  @override
  String get pageRegisterVisitSuccess => 'Visit registered successfully';

  @override
  String get pageRegisterVisitUploadingImages => 'Uploading images...';

  @override
  String get pageRegisterVisitErrorRequiredImage =>
      'You must add at least one image';

  @override
  String get pageShipmentDetailsWithoutObservations => 'Without observations';

  @override
  String get pageShipmentDetailsIdShipment => 'Shipment ID';

  @override
  String get pageShipmentDetailsIdSale => 'Sale ID';

  @override
  String get pageShipmentDetailsTotalToClaim => 'Total to claim';

  @override
  String get pageShipmentDetailsWhoRecibeTheShipment =>
      'Package recipient is the buyer';

  @override
  String get pageShipmentDetailsNoLocationOfShipment =>
      'No shipment location of shipment';

  @override
  String get pageShipmentListTotalShipments => 'Total of shipments shown';

  @override
  String get pageShipmentListNoShipmentsAvailable => 'No shipments available';

  @override
  String get pageShipmentListTheShipmentDoesntHavePhoneNumber =>
      'This shipment does not have a phone number assigned.';

  @override
  String get pageShipmentListShipmentProximoAEntregar => 'Next to deliver';

  @override
  String get pageShipmentListTodaysPackagesAreNotBeingShown =>
      'Today\'s packages are not being shown';

  @override
  String get pageAccountsSellerId => 'Seller Id';

  @override
  String get pageSettlementsNoSettlements => 'No settlements available';

  @override
  String get pageSettlementsShipmentAddress => 'Shipment address';

  @override
  String get pageSettlementsWhoLiquidate => 'Who liquidate';

  @override
  String get pageSettlementsLiquidateDate => 'Liquidate date';

  @override
  String get pageSettlementsNoShipmentAvailable => 'No shipments available';

  @override
  String get pageSettlementsNumbersOfTrips => 'Number of trips';

  @override
  String get pageAppConfiguration => 'App configuration';

  @override
  String get pageAppConfigurationDefaultRegisterVisitStates =>
      'Default register visit states';

  @override
  String get pageAppConfigurationChangeGeoDriversHours =>
      'Change geodrivers hours';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursStartHour => 'Start hour';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursEndHour => 'End hour';

  @override
  String get pageAppConfigurationCheckPermissions => 'Check permissions';

  @override
  String get pageCheckPermissionsAlreadyAllowed =>
      'Permissions already granted';

  @override
  String get pageCheckPermissionsAlreadyAllowedDescription =>
      'The permissions are already granted';

  @override
  String get pageAppConfigurationCheckPermissionsAllowed =>
      'Permissions granted';

  @override
  String get pageCheckPermissionsAllowedDescription =>
      'The permission has been granted successfully';

  @override
  String get pageAppConfigurationCheckPermissionsDenied => 'Permissions denied';

  @override
  String get pageAppConfigurationNewWhatsappMessages =>
      'New whatsapp messages available';

  @override
  String get pageCollectCurrentRoute => 'Current route';

  @override
  String get pageCollectToCollect => 'To collect';

  @override
  String get pageCollectCollectList => 'Collect list';

  @override
  String get pageCollectSettlementList => 'Settlement list';

  @override
  String get pageCollectShipmentList => 'Shipment list';

  @override
  String get pageCollectCollectDetails => 'Collect details';

  @override
  String get pageCollectSellerDetails => 'Seller details';

  @override
  String get pageCollectSettlementDate => 'Settlement date';

  @override
  String get pageCollectSettlementRange => 'Settlement range';

  @override
  String get pageCollectSettlementDetails => 'Settlement details';

  @override
  String get pageCollectTotalToCollect => 'Total collect\'s';

  @override
  String get pageCollectTotalClients => 'Total clients';

  @override
  String get pageCollectTotalClientsToCollect => 'Total clients to collect';

  @override
  String get pageCollectNotEveryClientIsGeolocalized =>
      'Not every client is geolocalized';

  @override
  String get bottomNavigationBarOptionHome => 'Home';

  @override
  String get bottomNavigationBarOptionShipments => 'Shipments';

  @override
  String get bottomNavigationBarOptionQR => 'QR';

  @override
  String get bottomNavigationBarOptionMaps => 'Maps';

  @override
  String get bottomNavigationBarOptionProfile => 'Profile';

  @override
  String get bottomNavigationBarOptionSettings => 'Settings';

  @override
  String get bottomNavigationBarOptionMySettlements => 'My settlements';

  @override
  String get bottomNavigationBarOptionLogout => 'Logout';

  @override
  String get stateCollected => 'Collected';

  @override
  String get stateAtProcessingPlant => 'At processing plant';

  @override
  String get stateAtProcessingPlant2 => 'At processing plant 2';

  @override
  String get stateOnTheWay => 'On the way';

  @override
  String get stateReturningToProcessingPlant => 'Returning To Processing Plant';

  @override
  String get stateDelivered => 'Delivered';

  @override
  String get stateNobody => 'Nobody';

  @override
  String get stateToBeCollected => 'To be collected';

  @override
  String get stateCanceled => 'Canceled';

  @override
  String get stateDeliveredSecondVisit => 'Delivered second visit';

  @override
  String get stateNobodySecondVisit => 'Nobody second visit';

  @override
  String get stateOnTheWaySecondVisit => 'On the way second visit';

  @override
  String get stateOnTheWayRescheduled => 'On the way rescheduled';

  @override
  String get stateNotDelivered => 'Not delivered';

  @override
  String get stateReturnedToClient => 'Returned to client';

  @override
  String get stateRejectedByClient => 'Rejected by client';

  @override
  String get stateOnTheWayThirdVisit => 'On the way third visit';

  @override
  String get stateDeliveredThirdVisit => 'Delivered third visit';

  @override
  String get stateNobodyThirdVisit => 'Nobody third visit';

  @override
  String get stateDeliveredPickupPoint => 'Delivered pickup point';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get commonUser => 'User';

  @override
  String get commonFilter => 'Filter';

  @override
  String get commonLogin => 'Login';

  @override
  String get commonToday => 'Today';

  @override
  String get commonClose => 'Close';

  @override
  String get commonGenerate => 'Generate';

  @override
  String get commonId => 'Id';

  @override
  String get commonUbication => 'Location';

  @override
  String get commonSaveImage => 'Save Image';

  @override
  String get commonAddImage => 'Add Image';

  @override
  String get commonDeleteImage => 'Delete Image';

  @override
  String get commonSave => 'Save';

  @override
  String get commonUserName => 'User name';

  @override
  String get commonContact => 'Contact';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonCompany => 'Company';

  @override
  String get commonPlan => 'Plan';

  @override
  String get commonAccept => 'Accept';

  @override
  String get commonDriver => 'Driver';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonLoad => 'Load';

  @override
  String get commonHome => 'Home';

  @override
  String get commonCamera => 'Camera';

  @override
  String get commonGallery => 'Gallery';

  @override
  String get commonHistory => 'History';

  @override
  String get commonState => 'State';

  @override
  String get commonStates => 'States';

  @override
  String get commonLocation => 'Location';

  @override
  String get commonAddress => 'Address';

  @override
  String get commonDate => 'Date';

  @override
  String get commonDateFrom => 'Date from';

  @override
  String get commonDateTo => 'Date to';

  @override
  String get commonObservations => 'Observations';

  @override
  String get commonClient => 'Client';

  @override
  String get commonTotal => 'Total';

  @override
  String get commonTracking => 'Tracking';

  @override
  String get commonSettlements => 'Settlements';

  @override
  String get commonSelectADate => 'Select a date';

  @override
  String get commonPersonalData => 'Personal data';

  @override
  String get commonMyData => 'My data';

  @override
  String get commonOn => 'On';

  @override
  String get commonOff => 'Off';

  @override
  String get commonAssign => 'Assign';

  @override
  String get commonSKU => 'SKU';

  @override
  String get commonVariation => 'Variación';

  @override
  String get commonSource => 'Source';

  @override
  String get commonImportant => 'Important';

  @override
  String get commonIncorrectCode => 'Incorrect code';

  @override
  String get commonBack => 'Back';

  @override
  String get commonHouse => 'House';

  @override
  String get commonSelect => 'Select';

  @override
  String get commonSync => 'Sync';

  @override
  String get commonWithoutSync => 'Unsynced';

  @override
  String get commonNumber => 'Number';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSaved => 'Saved';

  @override
  String get commonFeatNotAvailableTitle => 'Feature not available';

  @override
  String get commonFeatNotAvailableDescription =>
      'This feature is not available in this version of the app.';

  @override
  String get commonInformationSavedSuccessfully =>
      'Your information has been saved successfully';

  @override
  String get commonOops => 'Oops';

  @override
  String get commonNoMovements => 'No movements to show';

  @override
  String get commonCP => 'CP';

  @override
  String get commonAccounts => 'Accounts';

  @override
  String get commonHi => 'Hi';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonOk => 'Ok';

  @override
  String get commonAdmitted => 'Admitted';

  @override
  String get commonSeconds => 'Seconds';

  @override
  String get commonError => 'Error';

  @override
  String get commonIUnderstand => 'I understand';

  @override
  String get commonPassword => 'Password';

  @override
  String get commonOf => 'of';

  @override
  String get commonNoInternet => 'No internet connection';

  @override
  String get commonNoAvailableWithoutInternet =>
      'This feature is not available without an internet connection.';

  @override
  String get commonErrorText =>
      'An error has occurred, please try deleting the cache and logging in again. If the problem persists, please contact support.';

  @override
  String get commonShipment => 'Shipment';

  @override
  String get commonVersion => 'Version';

  @override
  String get commonApp => 'App';

  @override
  String get commonCurrentPassword => 'Current password';

  @override
  String get commonNewPassword => 'New password';

  @override
  String get commonRepeatNewPassword => 'Repeat new password';

  @override
  String get commonSuccess => 'Success';

  @override
  String get commonChange => 'Change';

  @override
  String get commonBranch => 'Branch';

  @override
  String get commonNow => 'Now';

  @override
  String get commonNotifications => 'Notifications';

  @override
  String get commonCollect => 'Collect';

  @override
  String get commonStart => 'Start';

  @override
  String get commonSavedWithoutConnection => 'Saved without connection';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonUnAssign => 'Unassign';

  @override
  String commonSynchronizing(int current, int total) {
    return 'Synchronizing data $current of $total';
  }

  @override
  String get commonWhitoutInformation => 'No information';

  @override
  String get commonRegenerate => 'Regenerate';

  @override
  String get commonNoShipmentsAvailable => 'No shipments available';

  @override
  String get commonAmountToCharge => 'Amount to charge';

  @override
  String get commonAllowPermissions => 'Allow permissions';
}
