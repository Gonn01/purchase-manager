import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';

/// {@template Purchase}
/// Entidad que contiene la informacion de una compra
///
/// Entity that contains the information of a purchase
/// {@endtemplate}
class Purchase {
  /// {@macro Purchase}
  Purchase({
    required this.id,
    required this.amountOfQuotas,
    required this.totalAmount,
    required this.amountPerQuota,
    required this.nameOfProduct,
    required this.type,
    required this.creationDate,
    required this.currency,
    required this.logs,
    this.lastCuotaDate,
  });

  /// id de la compra
  ///
  /// id of the purchase
  final String id;

  /// Cantidad de cuotas de la compra
  ///
  /// Number of quotas of the purchase
  int amountOfQuotas;

  /// Monto total de la compra
  ///
  /// Total amount of the purchase
  double totalAmount;

  /// Monto por cuota de la compra
  ///
  /// Amount per quota of the purchase
  double amountPerQuota;

  /// Nombre del producto comprado
  ///
  /// Name of the product buyed
  String nameOfProduct;

  /// Tipo de compra
  ///
  /// Type of purchase
  PurchaseType type;

  /// Fecha de creacion de la compra
  ///
  /// Creation date of the purchase
  final DateTime creationDate;

  /// Fecha de pago de la ultima cuota
  ///
  /// Payment date of the last quota
  DateTime? lastCuotaDate;

  /// Tipo de moneda
  CurrencyType currency;

  /// Logs de la entidad financiera
  ///
  /// Logs of the financial entity
  final List<String> logs;
}
