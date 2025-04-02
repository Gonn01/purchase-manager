// ignore_for_file: public_member_api_docs

import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/logs.dart';

/// {@template Purchase}
/// Entidad que contiene la informacion de una compra
///
/// Entity that contains the information of a purchase
/// {@endtemplate}
class Purchase {
  /// {@macro Purchase}
  Purchase({
    required this.id,
    required this.createdAt,
    required this.finalizationDate,
    required this.firstQuotaDate,
    required this.ignored,
    required this.image,
    required this.amount,
    required this.amountPerQuota,
    required this.numberOfQuotas,
    required this.payedQuotas,
    required this.currencyType,
    required this.name,
    required this.type,
    required this.fixedExpense,
    required this.logs,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      finalizationDate: json['finalization_date'] == null
          ? null
          : DateTime.parse(json['finalization_date'] as String),
      firstQuotaDate: json['first_quota_date'] == null
          ? null
          : DateTime.parse(json['first_quota_date'] as String),
      ignored: json['ignored'] as bool,
      image: json['image'] as String?,
      amount: (json['amount'] as num).toDouble(),
      amountPerQuota: (json['amount_per_quota'] as num).toDouble(),
      numberOfQuotas: json['number_of_quotas'] as int,
      payedQuotas: json['payed_quotas'] as int,
      currencyType: CurrencyType.type(json['currency_type'] as int),
      name: json['name'] as String,
      type: PurchaseType.type(json['type'] as int),
      fixedExpense: json['fixed_expense'] as bool,
      logs: json['logs'] != null
          ? (json['logs'] as List)
              .map((e) => PurchaseLog.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
  final int id;
  final DateTime createdAt;
  final DateTime? finalizationDate;
  final DateTime? firstQuotaDate;
  final bool ignored;
  final String? image;
  final double amount;
  final double amountPerQuota;
  final int numberOfQuotas;
  final int payedQuotas;
  final CurrencyType currencyType;
  final String name;
  final PurchaseType type;
  final bool fixedExpense;
  final List<PurchaseLog> logs;

  /// Copia de la compra con los nuevos valores
  ///
  /// Copy of the purchase with the new values
  Purchase copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? finalizationDate,
    DateTime? firstQuotaDate,
    bool? ignored,
    String? image,
    double? amount,
    double? amountPerQuota,
    int? numberOfQuotas,
    int? payedQuotas,
    CurrencyType? currencyType,
    String? name,
    PurchaseType? type,
    bool? fixesExpenses,
    List<PurchaseLog>? logs,
  }) {
    return Purchase(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      finalizationDate: finalizationDate ?? this.finalizationDate,
      firstQuotaDate: firstQuotaDate ?? this.firstQuotaDate,
      ignored: ignored ?? this.ignored,
      image: image ?? this.image,
      amount: amount ?? this.amount,
      amountPerQuota: amountPerQuota ?? this.amountPerQuota,
      numberOfQuotas: numberOfQuotas ?? this.numberOfQuotas,
      payedQuotas: payedQuotas ?? this.payedQuotas,
      currencyType: currencyType ?? this.currencyType,
      name: name ?? this.name,
      type: type ?? this.type,
      fixedExpense: fixesExpenses ?? this.fixedExpense,
      logs: logs ?? this.logs,
    );
  }
}
