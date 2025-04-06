part of 'bloc_home.dart';

/// {@template BlocDashboardState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocHomeState {
  /// {@macro BlocInicioEstado}
  const BlocHomeState._({
    this.financialEntityList = const [],
    this.currency = const Currency.empty(),
    this.purchaseLoadingId,
    this.purchasesLoadingsIds = const [],
    this.images = const [],
    this.financialEntitySelected,
    this.selectedCurrency = CurrencyType.pesoArgentino,
    this.lastMovements = const [],
  });

  /// Estado previo.
  BlocHomeState.from(
    BlocHomeState previousState, {
    List<FinancialEntity>? financialEntityList,
    Currency? currency,
    int? purchaseLoadingId,
    List<int> purchasesLoadingsIds = const [],
    bool deleteSelectedShipmentId = false,
    bool deleteImage = false,
    List<XFile>? images,
    FinancialEntity? financialEntitySelected,
    CurrencyType? selectedCurrency,
    List<LastMovementLog>? lastMovements,
  }) : this._(
          financialEntityList:
              financialEntityList ?? previousState.financialEntityList,
          currency: currency ?? previousState.currency,
          purchaseLoadingId: deleteSelectedShipmentId
              ? null
              : purchaseLoadingId ?? previousState.purchaseLoadingId,
          purchasesLoadingsIds:
              deleteSelectedShipmentId ? [] : purchasesLoadingsIds,
          images: deleteImage ? [] : images ?? previousState.images,
          financialEntitySelected:
              financialEntitySelected ?? previousState.financialEntitySelected,
          selectedCurrency: selectedCurrency ?? previousState.selectedCurrency,
          lastMovements: lastMovements ?? previousState.lastMovements,
        );

  ///
  final CurrencyType selectedCurrency;

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> financialEntityList;
  final List<LastMovementLog> lastMovements;

  /// Moneda actual.
  ///
  /// Current currency.
  final Currency currency;

  /// Id de la compra que se está cargando.
  final int? purchaseLoadingId;
  final List<int> purchasesLoadingsIds;

  /// List of images that will be uploaded
  final List<XFile> images;

  /// Entidad financiera seleccionada.
  ///
  /// Selected financial entity.
  final FinancialEntity? financialEntitySelected;

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

/// {@template BlocDashboardStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocDashboardStateInitial extends BlocHomeState {
  /// {@macro BlocDashboardStateInitial}
  BlocDashboardStateInitial() : super._();
}

/// {@template BlocDashboardStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocDashboardStateLoading extends BlocHomeState {
  /// {@macro BlocDashboardStateLoading}
  BlocDashboardStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocDashboardStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocDashboardStateLoadingPurchase extends BlocHomeState {
  /// {@macro BlocDashboardStateLoading}
  BlocDashboardStateLoadingPurchase.from(
    super.previusState, {
    super.purchaseLoadingId,
    super.purchasesLoadingsIds,
  }) : super.from();
}

/// {@template BlocDashboardStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDashboardStateSuccess extends BlocHomeState {
  /// {@macro BlocDashboardStateSuccess}
  BlocDashboardStateSuccess.from(
    super.previusState, {
    super.financialEntityList,
    super.currency,
    super.deleteSelectedShipmentId,
    super.deleteImage,
    super.images,
    super.financialEntitySelected,
    super.selectedCurrency,
    super.lastMovements,
  }) : super.from();
}

/// {@template BlocDashboardStateSuccessSignOut}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDashboardStateSuccessSignOut extends BlocHomeState {
  /// {@macro BlocDashboardStateSuccessSignOut}
  BlocDashboardStateSuccessSignOut.from(super.previusState) : super.from();
}

/// {@template BlocDashboardStateSuccessPayingMonth}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDashboardStateSuccessPayingMonth extends BlocHomeState {
  /// {@macro BlocDashboardStateSuccessPayingMonth}
  BlocDashboardStateSuccessPayingMonth.from(
    super.previusState, {
    super.financialEntityList,
    super.deleteSelectedShipmentId,
  }) : super.from();
}

/// {@template BlocDashboardStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocDashboardStateError extends BlocHomeState {
  /// {@macro BlocDashboardStateError}
  BlocDashboardStateError.from(
    super.previusState, {
    required this.error,
  }) : super.from();

  /// Error message.
  final String error;
}
