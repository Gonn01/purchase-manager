part of 'bloc_dashboard.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// {@endtemplate}
abstract class BlocDashboardEvento extends Equatable {
  /// {@macro BlocInicioEvento}
  const BlocDashboardEvento();

  @override
  List<Object> get props => [];
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de inicio.
/// {@endtemplate}
class BlocDashboardEventInitialize extends BlocDashboardEvento {}

class BlocDashboardEventModifyAmountOfQuotas extends BlocDashboardEvento {
  const BlocDashboardEventModifyAmountOfQuotas({
    required this.idPurchase,
    required this.modificationType,
    required this.purchaseType,
  });
  final String idPurchase;
  final ModificationType modificationType;
  final PurchaseType purchaseType;
}

class BlocDashboardEventCreateFinancialEntity extends BlocDashboardEvento {
  const BlocDashboardEventCreateFinancialEntity({
    required this.financialEntityName,
  });
  final String financialEntityName;
}

class BlocDashboardEventDeleteFinancialEntity extends BlocDashboardEvento {
  const BlocDashboardEventDeleteFinancialEntity({
    required this.idFinancialEntity,
  });
  final String idFinancialEntity;
}

class BlocDashboardEventDeletePurchase extends BlocDashboardEvento {
  const BlocDashboardEventDeletePurchase({
    required this.idFinancialEntity,
    required this.idPurchase,
  });
  final String idFinancialEntity;
  final String idPurchase;
}

class BlocDashboardEventCreatePurchase extends BlocDashboardEvento {
  const BlocDashboardEventCreatePurchase({
    required this.productName,
    required this.totalAmount,
    required this.amountQuotas,
    required this.idFinancialEntity,
    required this.purchaseType,
    required this.currency,
  });
  final String productName;
  final double totalAmount;
  final int amountQuotas;
  final String idFinancialEntity;
  final PurchaseType purchaseType;
  final Currency currency;
}

class BlocDashboardEventEditPurchase extends BlocDashboardEvento {
  const BlocDashboardEventEditPurchase({
    required this.purchase,
    required this.productName,
    required this.amount,
    required this.amountOfQuotas,
    required this.idFinancialEntity,
    required this.purchaseType,
    required this.currency,
  });
  final Purchase purchase;
  final String productName;
  final double amount;
  final int amountOfQuotas;
  final String idFinancialEntity;
  final PurchaseType purchaseType;
  final Currency currency;
}

enum ModificationType {
  decrease,
  increase,
}
