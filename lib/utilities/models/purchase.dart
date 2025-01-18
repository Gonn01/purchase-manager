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
    required this.amountOfQuotas,
    required this.totalAmount,
    required this.amountPerQuota,
    required this.nameOfProduct,
    required this.type,
    required this.creationDate,
    required this.currency,
    required this.logs,
    required this.quotasPayed,
    this.id,
    this.lastQuotaDate,
    this.firstQuotaDate,
  });

  /// id de la compra
  ///
  /// id of the purchase
  String? id;

  /// Cantidad de cuotas de la compra
  ///
  /// Number of quotas of the purchase
  int amountOfQuotas;

  /// Cuotas pagadas de la compra
  ///
  /// Payed quotas of the purchase
  int quotasPayed;

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
  String? lastQuotaDate;

  /// Fecha de pago de la primera cuota
  ///
  /// Payment date of the first quota
  String? firstQuotaDate;

  /// Tipo de moneda
  CurrencyType currency;

  /// Logs de la entidad financiera
  ///
  /// Logs of the financial entity
  final List<String> logs;

  Purchase copyWith({
    String? id,
    int? amountOfQuotas,
    int? quotasPayed,
    double? totalAmount,
    double? amountPerQuota,
    String? nameOfProduct,
    PurchaseType? type,
    DateTime? creationDate,
    String? lastQuotaDate,
    String? firstQuotaDate,
    CurrencyType? currency,
    List<String>? logs,
  }) {
    return Purchase(
      id: id ?? this.id,
      amountOfQuotas: amountOfQuotas ?? this.amountOfQuotas,
      quotasPayed: quotasPayed ?? this.quotasPayed,
      totalAmount: totalAmount ?? this.totalAmount,
      amountPerQuota: amountPerQuota ?? this.amountPerQuota,
      nameOfProduct: nameOfProduct ?? this.nameOfProduct,
      type: type ?? this.type,
      creationDate: creationDate ?? this.creationDate,
      lastQuotaDate: lastQuotaDate ?? this.lastQuotaDate,
      firstQuotaDate: firstQuotaDate ?? this.firstQuotaDate,
      currency: currency ?? this.currency,
      logs: logs ?? this.logs,
    );
  }
}
