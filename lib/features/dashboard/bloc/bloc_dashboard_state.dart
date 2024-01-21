part of 'bloc_dashboard.dart';

/// {@template BlocInicioEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocDashboardState extends Equatable {
  /// {@macro BlocInicioEstado}
  const BlocDashboardState({
    this.financialEntityList = const [],
    this.status = Status.initial,
    this.coin,
  });

  final List<FinancialEntity> financialEntityList;

  final Status status;

  final Coin? coin;

  List<FinancialEntity> get listFinancialEntitiesStatusCurrentDebtor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) => purchase.type.isCurrent && purchase.type.isDebtor,
              ))
          .toList();

  List<Purchase> listPurchaseStatusCurrentDebtor(FinancialEntity categoria) =>
      categoria.purchases
          .where(
              (purchase) => purchase.type.isCurrent && purchase.type.isDebtor)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusCurrentCreditor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (compra) => compra.type.isCurrent && !compra.type.isDebtor,
              ))
          .toList();

  List<Purchase> listPurchaseStatusCurrentCreditor(
          FinancialEntity financialEntity) =>
      financialEntity.purchases
          .where(
              (purchase) => purchase.type.isCurrent && !purchase.type.isDebtor)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusHistoryDebtor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) =>
                    !purchase.type.isCurrent && purchase.type.isDebtor,
              ))
          .toList();

  List<Purchase> listPurchaseStatusHistoryDebtor(FinancialEntity categoria) =>
      categoria.purchases
          .where((compra) => !compra.type.isCurrent && compra.type.isDebtor)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusHistoryCreditor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) =>
                    !purchase.type.isCurrent && !purchase.type.isDebtor,
              ))
          .toList();

  List<Purchase> listPurchaseStatusHistoryCreditor(FinancialEntity categoria) =>
      categoria.purchases
          .where((compra) => !compra.type.isCurrent && !compra.type.isDebtor)
          .toList();

  @override
  List<dynamic> get props => [
        status,
        financialEntityList,
        coin,
      ];

  BlocDashboardState copyWith({
    List<FinancialEntity>? listaCategorias,
    Status? estado,
    String? mensajeError,
    Coin? coin,
  }) {
    return BlocDashboardState(
      financialEntityList: listaCategorias ?? financialEntityList,
      status: estado ?? status,
      coin: coin ?? this.coin,
    );
  }
}
