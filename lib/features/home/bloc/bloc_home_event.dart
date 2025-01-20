part of 'bloc_home.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocHomeEvento {
  /// {@macro BlocInicioEvento}
  const BlocHomeEvento();
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocHomeEventInitialize extends BlocHomeEvento {}

/// {@template BlocHomeEventModifyAmountOfQuotas}
/// Modifica la cantidad de cuotas de una compra.
/// Modify the number of quotas of a purchase.
/// {@endtemplate}
class BlocHomeEventIncreaseAmountOfQuotas extends BlocHomeEvento {
  ///{@macro BlocHomeEventModifyAmountOfQuotas}
  const BlocHomeEventIncreaseAmountOfQuotas({
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

/// {@template BlocHomeEventPayQuota}
/// Modifica la cantidad de cuotas de una compra.
/// Modify the number of quotas of a purchase.
/// {@endtemplate}
class BlocHomeEventPayQuota extends BlocHomeEvento {
  ///{@macro BlocHomeEventPayQuota}
  const BlocHomeEventPayQuota({
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

/// {@template BlocHomeEventCreateFinancialEntity}
/// Crea una nueva categoría.
/// Creates a new category.
/// {@endtemplate}
class BlocHomeEventCreateFinancialEntity extends BlocHomeEvento {
  ///{@macro BlocHomeEventCreateFinancialEntity}
  const BlocHomeEventCreateFinancialEntity({
    required this.financialEntityName,
  });

  /// Nombre de la categoría a crear.
  /// Name of the category to create.
  final String financialEntityName;
}

/// {@template BlocHomeEventDeleteFinancialEntity}
/// Elimina una categoría.
/// Deletes a category.
/// {@endtemplate}
class BlocHomeEventDeleteFinancialEntity extends BlocHomeEvento {
  ///{@macro BlocHomeEventDeleteFinancialEntity}
  const BlocHomeEventDeleteFinancialEntity({
    required this.idFinancialEntity,
  });

  /// ID de la categoría a eliminar.
  final String idFinancialEntity;
}

/// {@template BlocHomeEventDeletePurchase}
/// Elimina una compra.
/// Deletes a purchase.
/// {@endtemplate}
class BlocHomeEventDeletePurchase extends BlocHomeEvento {
  ///{@macro BlocHomeEventDeletePurchase}
  const BlocHomeEventDeletePurchase({
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

/// {@template BlocHomeEventCreatePurchase}
/// Crea una nueva compra.
/// Creates a new purchase.
/// {@endtemplate}
class BlocHomeEventCreatePurchase extends BlocHomeEvento {
  ///{@macro BlocHomeEventCreatePurchase}
  const BlocHomeEventCreatePurchase({
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

/// {@template BlocHomeEventEditPurchase}
/// Edita una compra.
/// Edit a purchase.
/// {@endtemplate}
class BlocHomeEventEditPurchase extends BlocHomeEvento {
  ///{@macro BlocHomeEventEditPurchase}
  const BlocHomeEventEditPurchase({
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

/// {@template BlocHomeEventoPayMonth}
/// Paga una cuota de una compra.
/// Pay a quota of a purchase.
/// {@endtemplate}
class BlocHomeEventPayMonth extends BlocHomeEvento {
  ///{@macro BlocHomeEventoPayMonth}
  const BlocHomeEventPayMonth({
    required this.purchaseList,
    required this.idFinancialEntity,
  });

  /// ID de la categoría a la que pertenece la compra.
  ///
  /// ID of the category to which the purchase belongs.
  final List<Purchase> purchaseList;

  final String idFinancialEntity;
}
