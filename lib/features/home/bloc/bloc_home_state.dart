part of 'bloc_home.dart';

/// {@template BlocHomeState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocHomeState extends Equatable {
  /// {@macro BlocInicioEstado}
  const BlocHomeState({
    this.financialEntityList = const [],
    this.status = Status.initial,
    this.currency,
  });

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> financialEntityList;

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  /// Moneda actual.
  ///
  /// Current currency.
  final Currency? currency;

  /// Lista de [FinancialEntity] que tienen compras de
  /// [PurchaseType.currentDebtorPurchase]
  ///
  /// List of financial entities that have purchases of
  /// [PurchaseType.currentDebtorPurchase]
  List<FinancialEntity> get listFinancialEntitiesStatusCurrentDebtor =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) => purchase.type == PurchaseType.currentDebtorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.currentDebtorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.currentDebtorPurchase].
  List<Purchase> listPurchaseStatusCurrentDebtor(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) =>
                purchase.type == PurchaseType.currentDebtorPurchase ||
                purchase.type == PurchaseType.currentCreditorPurchase,
          )
          .toList();

  /// Lista de [FinancialEntity] de que tienen compras de
  /// [PurchaseType.currentCreditorPurchase]
  /// List of financial entities that have purchases of
  /// [PurchaseType.currentCreditorPurchase]
  List<FinancialEntity> get listFinancialEntityStatusCurrentCreditor =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) =>
                  purchase.type == PurchaseType.currentCreditorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.currentCreditorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.currentCreditorPurchase].
  List<Purchase> listPurchaseStatusCurrentCreditor(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) => purchase.type == PurchaseType.currentCreditorPurchase,
          )
          .toList();

  /// Lista de [FinancialEntity] que tienen compras de
  /// [PurchaseType.settledDebtorPurchase]
  ///
  /// List of financial entities that have purchases of
  /// [PurchaseType.settledDebtorPurchase]
  List<FinancialEntity> get listFinancialEntityStatusSettledDebtor =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) => purchase.type == PurchaseType.settledDebtorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.settledDebtorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.settledDebtorPurchase].
  List<Purchase> listPurchaseStatusSettledDebtor(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) => purchase.type == PurchaseType.settledDebtorPurchase,
          )
          .toList();

  /// Lista de entidades financieras que tienen compras de
  /// [PurchaseType.settledCreditorPurchase]
  ///
  /// List of financial entities that have purchases of
  /// [PurchaseType.settledCreditorPurchase]
  List<FinancialEntity> get listFinancialEntityStatusSettledCreditor =>
      financialEntityList
          .where(
            (financialEntity) => financialEntity.purchases.any(
              (purchase) =>
                  purchase.type == PurchaseType.settledCreditorPurchase,
            ),
          )
          .toList();

  /// Lista de [Purchase] que tiene la [FinancialEntity] de
  /// [PurchaseType.settledCreditorPurchase].
  ///
  /// List of [Purchase] that the [FinancialEntity] has with
  /// [PurchaseType.settledCreditorPurchase].
  List<Purchase> listPurchaseStatusSettledCreditor(
    FinancialEntity financialEntity,
  ) =>
      financialEntity.purchases
          .where(
            (purchase) => purchase.type == PurchaseType.settledCreditorPurchase,
          )
          .toList();

  /// Calcula el total de la suma de una cuota de las compras deudoras actuales.
  ///
  /// Calculate the total of the sum of a quota of the current debtor purchases.
  double totalAmountPerMonth({required List<Purchase> purchases}) {
    return purchases.fold<double>(
      0,
      (previousValue, purchase) => previousValue + purchase.amountPerQuota,
    );
  }

  @override
  List<dynamic> get props => [
        status,
        financialEntityList,
        currency,
      ];

  /// Copia el estado actual y lo modifica con los parámetros proporcionados.
  /// Copy the current state and modify it with the provided parameters.
  BlocHomeState copyWith({
    List<FinancialEntity>? financialEntityList,
    Status? estado,
    Currency? coin,
  }) {
    return BlocHomeState(
      financialEntityList: financialEntityList ?? this.financialEntityList,
      status: estado ?? status,
      currency: coin,
    );
  }
}
