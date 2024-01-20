part of 'bloc_dashboard.dart';

/// {@template BlocInicioEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocDashboardState extends Equatable {
  /// {@macro BlocInicioEstado}
  const BlocDashboardState({
    this.financialEntityList = const [],
    this.status = Status.initial,
  });

  final List<FinancialEntity> financialEntityList;

  final Status status;

  List<FinancialEntity> get listFinancialEntitiesStatusCurrentDebt =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) => purchase.current && purchase.debt,
              ))
          .toList();

  List<Purchase> listPurchaseStatusCurrentDebt(FinancialEntity categoria) =>
      categoria.purchases
          .where((purchase) => purchase.current && purchase.debt)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusCurrentDebtor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (compra) => compra.current && !compra.debt,
              ))
          .toList();

  List<Purchase> listPurchaseStatusCurrentDebtor(
          FinancialEntity financialEntity) =>
      financialEntity.purchases
          .where((purchase) => purchase.current && !purchase.debt)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusHistoryDebt =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) => !purchase.current && purchase.debt,
              ))
          .toList();

  List<Purchase> listPurchaseStatusHistoryDebt(FinancialEntity categoria) =>
      categoria.purchases
          .where((compra) => !compra.current && compra.debt)
          .toList();

  List<FinancialEntity> get listFinancialEntityStatusHistoryDebtor =>
      financialEntityList
          .where((financialEntity) => financialEntity.purchases.any(
                (purchase) => !purchase.current && !purchase.debt,
              ))
          .toList();

  List<Purchase> listPurchaseStatusHistoryDebtor(FinancialEntity categoria) =>
      categoria.purchases
          .where((compra) => !compra.current && !compra.debt)
          .toList();

  @override
  List<Object> get props => [
        status,
        financialEntityList,
      ];

  BlocDashboardState copyWith({
    List<FinancialEntity>? listaCategorias,
    Status? estado,
    String? mensajeError,
  }) {
    return BlocDashboardState(
      financialEntityList: listaCategorias ?? financialEntityList,
      status: estado ?? status,
    );
  }
}
