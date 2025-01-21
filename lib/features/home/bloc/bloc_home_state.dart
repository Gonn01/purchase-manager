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
    this.currency,
    this.purchaseLoadingId,
    this.images = const [],
  });

  /// Estado previo.
  BlocHomeState.from(
    BlocHomeState previousState, {
    List<FinancialEntity>? financialEntityList,
    Currency? currency,
    String? purchaseLoadingId,
    bool deleteSelectedShipmentId = false,
    List<XFile>? images,
  }) : this._(
          financialEntityList:
              financialEntityList ?? previousState.financialEntityList,
          currency: currency ?? previousState.currency,
          purchaseLoadingId: deleteSelectedShipmentId
              ? null
              : purchaseLoadingId ?? previousState.purchaseLoadingId,
          images: images ?? previousState.images,
        );

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> financialEntityList;

  /// Moneda actual.
  ///
  /// Current currency.
  final Currency? currency;

  /// Id de la compra que se está cargando.
  final String? purchaseLoadingId;

  /// List of images that will be uploaded
  final List<XFile> images;

  /// Lista de [FinancialEntity] que tienen compras de
  /// [PurchaseType.currentDebtorPurchase]
  ///
  /// List of financial entities that have purchases of
  /// [PurchaseType.currentDebtorPurchase]
  List<FinancialEntity> get listFinancialEntitiesStatusCurrent =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) =>
                  purchase.type == PurchaseType.currentDebtorPurchase ||
                  purchase.type == PurchaseType.currentCreditorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.currentCreditorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.currentCreditorPurchase].
  List<Purchase> listPurchaseStatusCurrent(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) =>
                purchase.type == PurchaseType.currentCreditorPurchase ||
                purchase.type == PurchaseType.currentDebtorPurchase,
          )
          .toList();

  /// Lista de [FinancialEntity] que tienen compras de
  /// [PurchaseType.settledDebtorPurchase]
  ///
  /// List of financial entities that have purchases of
  /// [PurchaseType.settledDebtorPurchase]
  List<FinancialEntity> get listFinancialEntityStatusSettled =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) =>
                  purchase.type == PurchaseType.settledDebtorPurchase ||
                  purchase.type == PurchaseType.settledCreditorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.settledDebtorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.settledDebtorPurchase].
  List<Purchase> listPurchaseStatusSettled(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) =>
                purchase.type == PurchaseType.settledDebtorPurchase ||
                purchase.type == PurchaseType.settledCreditorPurchase,
          )
          .toList();
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
    super.currency,
    super.deleteSelectedShipmentId,
    super.images,
  }) : super.from();
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
    required this.error,
  }) : super.from();

  /// Error message.
  final String error;
}
