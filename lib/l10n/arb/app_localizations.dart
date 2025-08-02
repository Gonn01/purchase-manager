import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get pageIdentificationEnterYourCode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter the company code\nassigned to you'**
  String get pageIdentificationEnterTheCompanyCode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lightdata app collects location data to enable positioning of shipments and possible routing of deliveries even when the app is closed or not in use.'**
  String get pageLoginAskForLocationWhenInUsePermission;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lightdata is an application that will collect the cell phone location in the background to offer a better work tool. This way, the position of the shipment will be known at all times.'**
  String get pageLoginAskForLocationAlwaysPermission;

  ///
  ///
  /// In en, this message translates to:
  /// **'Lightdata app collects location data to:\n- Enable positioning of shipments and routing of deliveries.\n- Provide a better work tool by tracking the shipment location in real time.\n\nThis data is collected even when the app is closed or not in use.(background)\n\nLearn more about how we use your location data in our'**
  String get pageLoginAskForPermissions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bad credentials'**
  String get pageLoginBadCredentials;

  ///
  ///
  /// In en, this message translates to:
  /// **'We have another app for Pro Courrier, please download it from the store.'**
  String get pageLoginProCourrierError;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipments from '**
  String get pageHomeTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipments\n delivered today'**
  String get pageHomeOptionShipmentsDeliveredToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Todays\nassigned shipments'**
  String get pageHomeOptionTodaysAssignedShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get pageHomeOptionShipmentsOnTheWay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Closed\nshipments'**
  String get pageHomeOptionClosedShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'Pending\nshipments'**
  String get pageHomeOptionPendingShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'Start route'**
  String get pageHomeStartRoute;

  ///
  ///
  /// In en, this message translates to:
  /// **'Finish route'**
  String get pageHomeFinishRoute;

  ///
  ///
  /// In en, this message translates to:
  /// **'QR code not valid'**
  String get pageQrScanInvalidQR;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select a QR reader'**
  String get pageQrMenuTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'To processing\n plant'**
  String get pageQrMenuOptionToProcessingPlant;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get pageQrMenuOptionCollect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Success scanning QR'**
  String get pageQrScanSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Read QR'**
  String get pageQrMenuOptionReadQr;

  ///
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get pageQrMenuOptionAssign;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cross Docking'**
  String get pageQrMenuOptionCrossDocking;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipment\n information'**
  String get pageQrMenuOptionShipmentInformation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter flex'**
  String get pageQrMenuOptionEnterFlex;

  ///
  ///
  /// In en, this message translates to:
  /// **'Retired today by me'**
  String get pageQrCollectCollectedTodayByMe;

  ///
  ///
  /// In en, this message translates to:
  /// **'Today for me in the day'**
  String get pageQrProccessingPlantTodayForMeInTheDay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Customer today'**
  String get pageQrProccessingPlantCustomerToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Missings at the entrance floor today ({clientName})'**
  String pageQrProccessingPlantMissings(String clientName);

  ///
  ///
  /// In en, this message translates to:
  /// **'Read now'**
  String get pageQrReadNow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Scan the QR'**
  String get pageQrScanTheQR;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delivery area'**
  String get pageQrDeliveryArea;

  ///
  ///
  /// In en, this message translates to:
  /// **'Read QR DNI'**
  String get pageQrReadQRDni;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save visit'**
  String get pageQrSaveVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Register visit'**
  String get pageQrRegisterVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Self-assign'**
  String get pageQrSelfAssign;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total to withdraw customer'**
  String get pageQrCollectTotalToCollectClient;

  ///
  ///
  /// In en, this message translates to:
  /// **'To collect today'**
  String get pageQrCollectToCollectToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collected today'**
  String get pageQrCollectCollectedToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get pageFiltersApplyFilters;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clean filters'**
  String get pageFiltersCleanFilters;

  ///
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get pageFiltersRecipientName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Client name'**
  String get pageFiltersClientName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Orderer amount'**
  String get pageShipmentProductsOrderedAmount;

  ///
  ///
  /// In en, this message translates to:
  /// **'Last reading'**
  String get pageShipmentProductsLastReading;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipments assigned today'**
  String get pageShipmentAssignmentAmountOfShipmentsAssignedToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose a driver'**
  String get pageShipmentAssignmentChooseADriver;

  ///
  ///
  /// In en, this message translates to:
  /// **'Generate routes'**
  String get pageMapsGenerateRoutes;

  ///
  ///
  /// In en, this message translates to:
  /// **'Geolocate'**
  String get pageMapsGeolocate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total of shipments geolocated'**
  String get pageMapsCardDataItemNumberOfShipmentsGeolocated;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total of shipments without geolocation'**
  String get pageMapsCardDataItemNumberOfShipmentsWithoutGeolocation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Distance in kilometers'**
  String get pageMapsCardDataItemDistanceInKm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Distance time'**
  String get pageMapsCardDataItemDistanceTime;

  ///
  ///
  /// In en, this message translates to:
  /// **'Depot'**
  String get pageMapsDepot;

  ///
  ///
  /// In en, this message translates to:
  /// **'Last shipment'**
  String get pageMapsLastShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'My current location'**
  String get pageMapsMyCurrentLocation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipments without geolocate'**
  String get pageMapsShipmentsWithoutGeolocate;

  ///
  ///
  /// In en, this message translates to:
  /// **'You have to select one of the shipments to generate the route.'**
  String get pageMapsAlertYouHaveToSelectAShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Avoid highways'**
  String get pageMapsAvoidHighways;

  ///
  ///
  /// In en, this message translates to:
  /// **'Avoid tollways'**
  String get pageMapsAvoidTollways;

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose where to finish'**
  String get pageMapsChooseWhereToFinish;

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose where to start'**
  String get pageMapsChooseWhereToStart;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select a location'**
  String get pageMapsSelectALocation;

  ///
  ///
  /// In en, this message translates to:
  /// **'No geolocated shipments'**
  String get pageMapsNoGeolocatedShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'Route generated correctly'**
  String get pageMapsRouteGeneratedCorrectly;

  ///
  ///
  /// In en, this message translates to:
  /// **'Forget session'**
  String get pageProfileForgetSession;

  ///
  ///
  /// In en, this message translates to:
  /// **'Profile picture'**
  String get pageProfileProfilePicture;

  ///
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this picture?'**
  String get pageProfileDeletePictureConfirmation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Integrations links'**
  String get pageProfileIntegrationsLinks;

  ///
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to delete cache?'**
  String get pageProfileAreYouSureThatYouWantToDeleteCache;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get pageProfileClearCache;

  ///
  ///
  /// In en, this message translates to:
  /// **'Profile picture changed successfully'**
  String get pageProfileProfilePictureChangedSuccessfully;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get pageProfileChangePassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Success editing personal data'**
  String get pageProfileSuccessEditingPersonalData;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change icon'**
  String get pageProfileChangeIcon;

  ///
  ///
  /// In en, this message translates to:
  /// **'Add observations'**
  String get pageRegisterVisitAddObservations;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receiver\'s DNI'**
  String get pageRegisterVisitDNIOfTheRecipient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receiver\'s RUT'**
  String get pageRegisterVisitRUTOfTheRecipient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Receiver\'s C.C.'**
  String get pageRegisterVisitCCOfTheRecipient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Name of the recipient'**
  String get pageRegisterVisitNameOfTheRecipient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Register visit'**
  String get pageRegisterVisitRegisterVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'You have reached the image limit'**
  String get pageRegisterVisitImageLimitAlert;

  ///
  ///
  /// In en, this message translates to:
  /// **'Visit registered successfully'**
  String get pageRegisterVisitSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Uploading images...'**
  String get pageRegisterVisitUploadingImages;

  ///
  ///
  /// In en, this message translates to:
  /// **'You must add at least one image'**
  String get pageRegisterVisitErrorRequiredImage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Without observations'**
  String get pageShipmentDetailsWithoutObservations;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipment ID'**
  String get pageShipmentDetailsIdShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sale ID'**
  String get pageShipmentDetailsIdSale;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total to claim'**
  String get pageShipmentDetailsTotalToClaim;

  ///
  ///
  /// In en, this message translates to:
  /// **'Package recipient is the buyer'**
  String get pageShipmentDetailsWhoRecibeTheShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'No shipment location of shipment'**
  String get pageShipmentDetailsNoLocationOfShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total of shipments shown'**
  String get pageShipmentListTotalShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'No shipments available'**
  String get pageShipmentListNoShipmentsAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'This shipment does not have a phone number assigned.'**
  String get pageShipmentListTheShipmentDoesntHavePhoneNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Next to deliver'**
  String get pageShipmentListShipmentProximoAEntregar;

  ///
  ///
  /// In en, this message translates to:
  /// **'Today\'s packages are not being shown'**
  String get pageShipmentListTodaysPackagesAreNotBeingShown;

  ///
  ///
  /// In en, this message translates to:
  /// **'Seller Id'**
  String get pageAccountsSellerId;

  ///
  ///
  /// In en, this message translates to:
  /// **'No settlements available'**
  String get pageSettlementsNoSettlements;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipment address'**
  String get pageSettlementsShipmentAddress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Who liquidate'**
  String get pageSettlementsWhoLiquidate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Liquidate date'**
  String get pageSettlementsLiquidateDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'No shipments available'**
  String get pageSettlementsNoShipmentAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'Number of trips'**
  String get pageSettlementsNumbersOfTrips;

  ///
  ///
  /// In en, this message translates to:
  /// **'App configuration'**
  String get pageAppConfiguration;

  ///
  ///
  /// In en, this message translates to:
  /// **'Default register visit states'**
  String get pageAppConfigurationDefaultRegisterVisitStates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change geodrivers hours'**
  String get pageAppConfigurationChangeGeoDriversHours;

  ///
  ///
  /// In en, this message translates to:
  /// **'Start hour'**
  String get pageAppConfigurationChangeGeoDriversHoursStartHour;

  ///
  ///
  /// In en, this message translates to:
  /// **'End hour'**
  String get pageAppConfigurationChangeGeoDriversHoursEndHour;

  ///
  ///
  /// In en, this message translates to:
  /// **'Check permissions'**
  String get pageAppConfigurationCheckPermissions;

  ///
  ///
  /// In en, this message translates to:
  /// **'Permissions already granted'**
  String get pageCheckPermissionsAlreadyAllowed;

  ///
  ///
  /// In en, this message translates to:
  /// **'The permissions are already granted'**
  String get pageCheckPermissionsAlreadyAllowedDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Permissions granted'**
  String get pageAppConfigurationCheckPermissionsAllowed;

  ///
  ///
  /// In en, this message translates to:
  /// **'The permission has been granted successfully'**
  String get pageCheckPermissionsAllowedDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Permissions denied'**
  String get pageAppConfigurationCheckPermissionsDenied;

  ///
  ///
  /// In en, this message translates to:
  /// **'New whatsapp messages available'**
  String get pageAppConfigurationNewWhatsappMessages;

  ///
  ///
  /// In en, this message translates to:
  /// **'Current route'**
  String get pageCollectCurrentRoute;

  ///
  ///
  /// In en, this message translates to:
  /// **'To collect'**
  String get pageCollectToCollect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collect list'**
  String get pageCollectCollectList;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settlement list'**
  String get pageCollectSettlementList;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipment list'**
  String get pageCollectShipmentList;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collect details'**
  String get pageCollectCollectDetails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Seller details'**
  String get pageCollectSellerDetails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settlement date'**
  String get pageCollectSettlementDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settlement range'**
  String get pageCollectSettlementRange;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settlement details'**
  String get pageCollectSettlementDetails;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total collect\'s'**
  String get pageCollectTotalToCollect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total clients'**
  String get pageCollectTotalClients;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total clients to collect'**
  String get pageCollectTotalClientsToCollect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Not every client is geolocalized'**
  String get pageCollectNotEveryClientIsGeolocalized;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavigationBarOptionHome;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipments'**
  String get bottomNavigationBarOptionShipments;

  ///
  ///
  /// In en, this message translates to:
  /// **'QR'**
  String get bottomNavigationBarOptionQR;

  ///
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get bottomNavigationBarOptionMaps;

  ///
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavigationBarOptionProfile;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomNavigationBarOptionSettings;

  ///
  ///
  /// In en, this message translates to:
  /// **'My settlements'**
  String get bottomNavigationBarOptionMySettlements;

  ///
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get bottomNavigationBarOptionLogout;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get stateCollected;

  ///
  ///
  /// In en, this message translates to:
  /// **'At processing plant'**
  String get stateAtProcessingPlant;

  ///
  ///
  /// In en, this message translates to:
  /// **'At processing plant 2'**
  String get stateAtProcessingPlant2;

  ///
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get stateOnTheWay;

  ///
  ///
  /// In en, this message translates to:
  /// **'Returning To Processing Plant'**
  String get stateReturningToProcessingPlant;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get stateDelivered;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nobody'**
  String get stateNobody;

  ///
  ///
  /// In en, this message translates to:
  /// **'To be collected'**
  String get stateToBeCollected;

  ///
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get stateCanceled;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delivered second visit'**
  String get stateDeliveredSecondVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nobody second visit'**
  String get stateNobodySecondVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'On the way second visit'**
  String get stateOnTheWaySecondVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'On the way rescheduled'**
  String get stateOnTheWayRescheduled;

  ///
  ///
  /// In en, this message translates to:
  /// **'Not delivered'**
  String get stateNotDelivered;

  ///
  ///
  /// In en, this message translates to:
  /// **'Returned to client'**
  String get stateReturnedToClient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Rejected by client'**
  String get stateRejectedByClient;

  ///
  ///
  /// In en, this message translates to:
  /// **'On the way third visit'**
  String get stateOnTheWayThirdVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delivered third visit'**
  String get stateDeliveredThirdVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Nobody third visit'**
  String get stateNobodyThirdVisit;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delivered pickup point'**
  String get stateDeliveredPickupPoint;

  ///
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  ///
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  ///
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get languagePortuguese;

  ///
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get commonUser;

  ///
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get commonFilter;

  ///
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get commonLogin;

  ///
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get commonToday;

  ///
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  ///
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get commonGenerate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get commonId;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get commonUbication;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save Image'**
  String get commonSaveImage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get commonAddImage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delete Image'**
  String get commonDeleteImage;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  ///
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get commonUserName;

  ///
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get commonContact;

  ///
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get commonEmail;

  ///
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get commonCompany;

  ///
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get commonPlan;

  ///
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get commonAccept;

  ///
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get commonDriver;

  ///
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  ///
  ///
  /// In en, this message translates to:
  /// **'Load'**
  String get commonLoad;

  ///
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get commonHome;

  ///
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get commonCamera;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get commonGallery;

  ///
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get commonHistory;

  ///
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get commonState;

  ///
  ///
  /// In en, this message translates to:
  /// **'States'**
  String get commonStates;

  ///
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get commonLocation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get commonAddress;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get commonDate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date from'**
  String get commonDateFrom;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date to'**
  String get commonDateTo;

  ///
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get commonObservations;

  ///
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get commonClient;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get commonTotal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get commonTracking;

  ///
  ///
  /// In en, this message translates to:
  /// **'Settlements'**
  String get commonSettlements;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get commonSelectADate;

  ///
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get commonPersonalData;

  ///
  ///
  /// In en, this message translates to:
  /// **'My data'**
  String get commonMyData;

  ///
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get commonOn;

  ///
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get commonOff;

  ///
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get commonAssign;

  ///
  ///
  /// In en, this message translates to:
  /// **'SKU'**
  String get commonSKU;

  ///
  ///
  /// In en, this message translates to:
  /// **'Variación'**
  String get commonVariation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get commonSource;

  ///
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get commonImportant;

  ///
  ///
  /// In en, this message translates to:
  /// **'Incorrect code'**
  String get commonIncorrectCode;

  ///
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  ///
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get commonHouse;

  ///
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get commonSync;

  ///
  ///
  /// In en, this message translates to:
  /// **'Unsynced'**
  String get commonWithoutSync;

  ///
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get commonNumber;

  ///
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get commonSaved;

  ///
  ///
  /// In en, this message translates to:
  /// **'Feature not available'**
  String get commonFeatNotAvailableTitle;

  ///
  ///
  /// In en, this message translates to:
  /// **'This feature is not available in this version of the app.'**
  String get commonFeatNotAvailableDescription;

  ///
  ///
  /// In en, this message translates to:
  /// **'Your information has been saved successfully'**
  String get commonInformationSavedSuccessfully;

  ///
  ///
  /// In en, this message translates to:
  /// **'Oops'**
  String get commonOops;

  ///
  ///
  /// In en, this message translates to:
  /// **'No movements to show'**
  String get commonNoMovements;

  ///
  ///
  /// In en, this message translates to:
  /// **'CP'**
  String get commonCP;

  ///
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get commonAccounts;

  ///
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get commonHi;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get commonOk;

  ///
  ///
  /// In en, this message translates to:
  /// **'Admitted'**
  String get commonAdmitted;

  ///
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get commonSeconds;

  ///
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  ///
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get commonIUnderstand;

  ///
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get commonPassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get commonOf;

  ///
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get commonNoInternet;

  ///
  ///
  /// In en, this message translates to:
  /// **'This feature is not available without an internet connection.'**
  String get commonNoAvailableWithoutInternet;

  ///
  ///
  /// In en, this message translates to:
  /// **'An error has occurred, please try deleting the cache and logging in again. If the problem persists, please contact support.'**
  String get commonErrorText;

  ///
  ///
  /// In en, this message translates to:
  /// **'Shipment'**
  String get commonShipment;

  ///
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get commonVersion;

  ///
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get commonApp;

  ///
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get commonCurrentPassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get commonNewPassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Repeat new password'**
  String get commonRepeatNewPassword;

  ///
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  ///
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get commonChange;

  ///
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get commonBranch;

  ///
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get commonNow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get commonNotifications;

  ///
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get commonCollect;

  ///
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get commonStart;

  ///
  ///
  /// In en, this message translates to:
  /// **'Saved without connection'**
  String get commonSavedWithoutConnection;

  ///
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  ///
  ///
  /// In en, this message translates to:
  /// **'Unassign'**
  String get commonUnAssign;

  ///
  ///
  /// In en, this message translates to:
  /// **'Synchronizing data {current} of {total}'**
  String commonSynchronizing(int current, int total);

  ///
  ///
  /// In en, this message translates to:
  /// **'No information'**
  String get commonWhitoutInformation;

  ///
  ///
  /// In en, this message translates to:
  /// **'Regenerate'**
  String get commonRegenerate;

  ///
  ///
  /// In en, this message translates to:
  /// **'No shipments available'**
  String get commonNoShipmentsAvailable;

  ///
  ///
  /// In en, this message translates to:
  /// **'Amount to charge'**
  String get commonAmountToCharge;

  ///
  ///
  /// In en, this message translates to:
  /// **'Allow permissions'**
  String get commonAllowPermissions;
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
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
