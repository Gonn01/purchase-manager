part of 'bloc_dashboard.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocDashboardEvento extends Equatable {
  /// {@macro BlocInicioEvento}
  const BlocDashboardEvento();

  @override
  List<Object> get props => [];
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de dashboard.
/// Initialize the dashboard page.
/// {@endtemplate}
class BlocDashboardEventInitialize extends BlocDashboardEvento {}

/// {@template BlocDashboardEventModifyAmountOfQuotas}
/// Modifica la cantidad de cuotas de una compra.
/// Modify the number of quotas of a purchase.
/// {@endtemplate}
class BlocDashboardEventModifyAmountOfQuotas extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventModifyAmountOfQuotas}
  const BlocDashboardEventModifyAmountOfQuotas({
    required this.idPurchase,
    required this.modificationType,
    required this.purchaseType,
  });

  /// ID de la compra a modificar.
  /// ID of the purchase to modify.
  final String idPurchase;

  /// Tipo de modificación a realizar.
  /// Type of modification to perform.
  final ModificationType modificationType;

  /// Tipo de compra a modificar.
  /// Type of purchase to modify.
  final PurchaseType purchaseType;
}

/// {@template BlocDashboardEventCreateFinancialEntity}
/// Crea una nueva categoría.
/// Creates a new category.
/// {@endtemplate}
class BlocDashboardEventCreateFinancialEntity extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventCreateFinancialEntity}
  const BlocDashboardEventCreateFinancialEntity({
    required this.financialEntityName,
  });

  /// Nombre de la categoría a crear.
  /// Name of the category to create.
  final String financialEntityName;
}

/// {@template BlocDashboardEventDeleteFinancialEntity}
/// Elimina una categoría.
/// Deletes a category.
/// {@endtemplate}
class BlocDashboardEventDeleteFinancialEntity extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventDeleteFinancialEntity}
  const BlocDashboardEventDeleteFinancialEntity({
    required this.idFinancialEntity,
  });

  /// ID de la categoría a eliminar.
  final String idFinancialEntity;
}

/// {@template BlocDashboardEventDeletePurchase}
/// Elimina una compra.
/// Deletes a purchase.
/// {@endtemplate}
class BlocDashboardEventDeletePurchase extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventDeletePurchase}
  const BlocDashboardEventDeletePurchase({
    required this.idFinancialEntity,
    required this.idPurchase,
  });

  /// ID de la categoría a la que pertenece la compra.
  /// ID of the category to which the purchase belongs.
  final String idFinancialEntity;

  /// ID de la compra a eliminar.
  /// ID of the purchase to delete.
  final String idPurchase;
}

/// {@template BlocDashboardEventCreatePurchase}
/// Crea una nueva compra.
/// Creates a new purchase.
/// {@endtemplate}
class BlocDashboardEventCreatePurchase extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventCreatePurchase}
  const BlocDashboardEventCreatePurchase({
    required this.productName,
    required this.totalAmount,
    required this.amountQuotas,
    required this.idFinancialEntity,
    required this.purchaseType,
    required this.currency,
  });

  /// Nombre del producto a comprar.
  /// Name of the product to buy.
  final String productName;

  /// Monto total de la compra.
  /// Total amount of the purchase.
  final double totalAmount;

  /// Cantidad de cuotas de la compra.
  /// Number of quotas of the purchase.
  final int amountQuotas;

  /// ID de la categoría a la que pertenece la compra.
  /// ID of the category to which the purchase belongs.
  final String idFinancialEntity;

  /// Tipo de compra.
  /// Type of purchase.
  final PurchaseType purchaseType;

  /// Tipo de moneda.
  /// Type of currency.
  final CurrencyType currency;
}

/// {@template BlocDashboardEventEditPurchase}
/// Edita una compra.
/// Edit a purchase.
/// {@endtemplate}
class BlocDashboardEventEditPurchase extends BlocDashboardEvento {
  ///{@macro BlocDashboardEventEditPurchase}
  const BlocDashboardEventEditPurchase({
    required this.purchase,
    required this.productName,
    required this.amount,
    required this.amountOfQuotas,
    required this.idFinancialEntity,
    required this.purchaseType,
    required this.currency,
  });

  /// Compra a editar.
  /// Purchase to edit.
  final Purchase purchase;

  /// Nombre del producto a comprar.
  /// Name of the product to buy.
  final String productName;

  /// Monto total de la compra.
  /// Total amount of the purchase.
  final double amount;

  /// Cantidad de cuotas de la compra.
  /// Number of quotas of the purchase.
  final int amountOfQuotas;

  /// ID de la categoría a la que pertenece la compra.
  /// ID of the category to which the purchase belongs.
  final String idFinancialEntity;

  /// Tipo de compra.
  /// Type of purchase.
  final PurchaseType purchaseType;

  /// Tipo de moneda.
  /// Type of currency.
  final CurrencyType currency;
}

/// {@template ModificationType}
/// Tipo de modificación a realizar.
/// Type of modification to perform.
/// {@endtemplate}
enum ModificationType {
  /// Disminuye la cantidad de cuotas.
  /// Decreases the number of quotas.
  decrease,

  /// Aumenta la cantidad de cuotas.
  /// Increases the number of quotas.
  increase,
}
