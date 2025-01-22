part of 'bloc_dashboard.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocDashboardEvent {
  /// {@macro BlocInicioEvento}
  const BlocDashboardEvent();
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocDashboardEventInitialize extends BlocDashboardEvent {}

/// {@template BlocDashboardEventModifyAmountOfQuotas}
/// Modifica la cantidad de cuotas de una compra.
/// Modify the number of quotas of a purchase.
/// {@endtemplate}
class BlocDashboardEventIncreaseAmountOfQuotas extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventModifyAmountOfQuotas}
  const BlocDashboardEventIncreaseAmountOfQuotas({
    required this.idPurchase,
    required this.purchaseType,
  });

  /// ID de la compra a modificar.
  /// ID of the purchase to modify.
  final String idPurchase;

  /// Tipo de compra a modificar.
  /// Type of purchase to modify.
  final PurchaseType purchaseType;
}

/// {@template BlocDashboardEventPayQuota}
/// Modifica la cantidad de cuotas de una compra.
/// Modify the number of quotas of a purchase.
/// {@endtemplate}
class BlocDashboardEventPayQuota extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventPayQuota}
  const BlocDashboardEventPayQuota({
    required this.idPurchase,
    required this.purchaseType,
  });

  /// ID de la compra a modificar.
  /// ID of the purchase to modify.
  final String idPurchase;

  /// Tipo de compra a modificar.
  /// Type of purchase to modify.
  final PurchaseType purchaseType;
}

/// {@template BlocDashboardEventCreateFinancialEntity}
/// Crea una nueva categoría.
/// Creates a new category.
/// {@endtemplate}
class BlocDashboardEventCreateFinancialEntity extends BlocDashboardEvent {
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
class BlocDashboardEventDeleteFinancialEntity extends BlocDashboardEvent {
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
class BlocDashboardEventDeletePurchase extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventDeletePurchase}
  const BlocDashboardEventDeletePurchase({
    required this.idFinancialEntity,
    required this.purchase,
  });

  /// ID de la categoría a la que pertenece la compra.
  /// ID of the category to which the purchase belongs.
  final String idFinancialEntity;

  /// ID de la compra a eliminar.
  /// ID of the purchase to delete.
  final Purchase purchase;
}

/// {@template BlocDashboardEventCreatePurchase}
/// Crea una nueva compra.
/// Creates a new purchase.
/// {@endtemplate}
class BlocDashboardEventCreatePurchase extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventCreatePurchase}
  const BlocDashboardEventCreatePurchase({
    required this.productName,
    required this.totalAmount,
    required this.amountQuotas,
    required this.financialEntity,
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
  final FinancialEntity financialEntity;

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
class BlocDashboardEventEditPurchase extends BlocDashboardEvent {
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

/// {@template BlocDashboardEventoPayMonth}
/// Paga una cuota de una compra.
/// Pay a quota of a purchase.
/// {@endtemplate}
class BlocDashboardEventPayMonth extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventoPayMonth}
  const BlocDashboardEventPayMonth({
    required this.purchaseList,
    required this.idFinancialEntity,
  });

  /// ID de la categoría a la que pertenece la compra.
  ///
  /// ID of the category to which the purchase belongs.
  final List<Purchase> purchaseList;

  /// Lista de compras a pagar.
  ///
  /// List of purchases to pay.
  final String idFinancialEntity;
}

/// {@template BlocDashboardEventAlternateIgnorePurchase}
/// Ignora una compra.
///
/// Ignore a purchase.
/// {@endtemplate}
class BlocDashboardEventAlternateIgnorePurchase extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventAlternateIgnorePurchase}
  const BlocDashboardEventAlternateIgnorePurchase({
    required this.purchaseId,
  });

  /// Compra a editar.
  /// Purchase to edit.
  final String purchaseId;
}

/// {@template BlocDashboardEventAddImage}
/// Add an image to the visit
/// {@endtemplate}
class BlocDashboardEventAddImage extends BlocDashboardEvent {
  /// {@macro BlocDashboardEventAddImage}
  const BlocDashboardEventAddImage({
    required this.image,
  });

  /// The id of the shipment
  final XFile image;
}

/// {@template BlocDashboardEventDeleteImageAt}
/// Delete an image from the visit
/// {@endtemplate}
class BlocDashboardEventDeleteImageAt extends BlocDashboardEvent {
  /// {@macro BlocDashboardEventDeleteImageAt}
  const BlocDashboardEventDeleteImageAt({
    required this.index,
  });

  /// The id of the shipment
  final int index;
}

/// {@template BlocDashboardEventSignOut}
/// Cierra sesión.
///
/// Sign out.
/// {@endtemplate}
class BlocDashboardEventSignOut extends BlocDashboardEvent {
  /// {@macro BlocDrawerEventSignOut}
  const BlocDashboardEventSignOut();
}

/// {@template BlocDashboardEventSelectFinancialEntity}
/// Selecciona una [FinancialEntity]
///
/// Select a [FinancialEntity]
/// {@endtemplate}
class BlocDashboardEventSelectFinancialEntity extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventSelectFinancialEntity}
  const BlocDashboardEventSelectFinancialEntity({
    required this.financialEntity,
  });

  /// [FinancialEntity] seleccionada
  ///
  /// Selected [FinancialEntity]
  final FinancialEntity financialEntity;
}
