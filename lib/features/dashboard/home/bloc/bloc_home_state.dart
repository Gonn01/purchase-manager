part of 'bloc_home.dart';

/// {@template BlocHomeState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocHomeState {
  /// {@macro BlocInicioEstado}
  const BlocHomeState._({
    this.financialEntityList = const [],
    this.purchaseLoadingId,
    this.purchasesLoadingsIds = const [],
    this.images = const [],
  });

  /// Estado previo.
  BlocHomeState.from(
    BlocHomeState previousState, {
    List<FinancialEntityHomeDto>? financialEntityList,
    int? purchaseLoadingId,
    List<int> purchasesLoadingsIds = const [],
    bool deleteSelectedShipmentId = false,
    bool deleteImage = false,
    List<XFile>? images,
  }) : this._(
          financialEntityList:
              financialEntityList ?? previousState.financialEntityList,
          purchaseLoadingId: deleteSelectedShipmentId
              ? null
              : purchaseLoadingId ?? previousState.purchaseLoadingId,
          purchasesLoadingsIds:
              deleteSelectedShipmentId ? [] : purchasesLoadingsIds,
          images: deleteImage ? [] : images ?? previousState.images,
        );

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntityHomeDto> financialEntityList;

  /// Id de la compra que se está cargando.
  final int? purchaseLoadingId;
  final List<int> purchasesLoadingsIds;

  /// List of images that will be uploaded
  final List<XFile> images;

  double totalAmountPerMonth(List<PurchaseHomeDto> list, Currency currency,
          CurrencyType currencyType) =>
      currencyType.totalAmountPerMonth(
        purchases: list,
        currency: currency,
      );
  List<FinancialEntityHomeDto> get financialEntitiesWithCurrentPurchases =>
      financialEntityList.where((e) => e.currentPurchases.isNotEmpty).toList();
  List<FinancialEntityHomeDto> get financialEntitiesWithSettledPurchases =>
      financialEntityList.where((e) => e.settledPurchases.isNotEmpty).toList();
  List<PurchaseHomeDto> currentPurchasesFromFinancialEntity(
          FinancialEntityHomeDto financialEntity) =>
      financialEntity.currentPurchases;

  List<PurchaseHomeDto> settledPurchasesFromFinancialEntity(
          FinancialEntityHomeDto financialEntity) =>
      financialEntity.settledPurchases;

  bool get hasCurrentPurchases => financialEntityList.any(
        (e) => e.currentPurchases.isNotEmpty,
      );

  bool get hasSettledPurchases => financialEntityList.any(
        (e) => e.settledPurchases.isNotEmpty,
      );
}

/// {@template BlocHomeStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocHomeStateInitial extends BlocHomeState {
  /// {@macro BlocHomeStateInitial}
  BlocHomeStateInitial() : super._();
}

/// {@template BlocHomeStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocHomeStateLoading extends BlocHomeState {
  /// {@macro BlocHomeStateLoading}
  BlocHomeStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocHomeStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocHomeStateLoadingPurchase extends BlocHomeState {
  /// {@macro BlocHomeStateLoading}
  BlocHomeStateLoadingPurchase.from(
    super.previusState, {
    super.purchaseLoadingId,
    super.purchasesLoadingsIds,
  }) : super.from();
}

/// {@template BlocHomeStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccess extends BlocHomeState {
  /// {@macro BlocHomeStateSuccess}
  BlocHomeStateSuccess.from(
    super.previusState, {
    super.financialEntityList,
    super.deleteSelectedShipmentId,
    super.deleteImage,
    super.images,
  }) : super.from();
}

/// {@template BlocHomeStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccessDeletingPurchase extends BlocHomeState {
  /// {@macro BlocHomeStateSuccess}
  BlocHomeStateSuccessDeletingPurchase.from(super.previusState,
      {super.financialEntityList})
      : super.from();
}

/// {@template BlocHomeStateSuccessPayingMonth}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocHomeStateSuccessPayingMonth extends BlocHomeState {
  /// {@macro BlocHomeStateSuccessPayingMonth}
  BlocHomeStateSuccessPayingMonth.from(
    super.previusState, {
    super.financialEntityList,
    super.deleteSelectedShipmentId,
  }) : super.from();
}

/// {@template BlocHomeStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocHomeStateError extends BlocHomeState {
  /// {@macro BlocHomeStateError}
  BlocHomeStateError.from(
    super.previusState, {
    required this.exception,
  }) : super.from();

  /// Error message.
  final CustomException exception;
}
