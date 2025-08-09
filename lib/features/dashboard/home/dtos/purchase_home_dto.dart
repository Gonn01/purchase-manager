import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';

class PurchaseHomeDto {
  const PurchaseHomeDto({
    required this.id,
    required this.finalizationDate,
    required this.firstQuotaDate,
    required this.ignored,
    this.image,
    required this.amount,
    required this.amountPerQuota,
    required this.numberOfQuotas,
    required this.payedQuotas,
    required this.currencyType,
    required this.name,
    required this.type,
    required this.fixedExpense,
    required this.financialEntityId,
  });
  factory PurchaseHomeDto.fromJson(Map<String, dynamic> json) {
    return PurchaseHomeDto(
      id: json['id'] as int,
      finalizationDate: json['finalization_date'] != null
          ? DateTime.parse(json['finalization_date'] as String)
          : null,
      firstQuotaDate: json['first_quota_date'] != null
          ? DateTime.parse(json['first_quota_date'] as String)
          : null,
      ignored: json['ignored'] as bool,
      image: json['image'] as String?,
      amount: (json['amount'] as num).toDouble(),
      amountPerQuota: (json['amount_per_quota'] as num?)?.toDouble() ?? 0.0,
      numberOfQuotas: json['number_of_quotas'] as int,
      payedQuotas: json['payed_quotas'] as int,
      currencyType: CurrencyType.type(json['currency_type'] as int),
      name: json['name'] as String,
      type: PurchaseType.type(json['type'] as int),
      fixedExpense: json['fixed_expense'] as bool,
      financialEntityId: json['financial_entity_id'] as int,
    );
  }

  final int id;
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
  final int financialEntityId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'finalization_date': finalizationDate?.toIso8601String(),
      'first_quota_date': firstQuotaDate?.toIso8601String(),
      'ignored': ignored,
      'image': image,
      'amount': amount,
      'amount_per_quota': amountPerQuota,
      'number_of_quotas': numberOfQuotas,
      'payed_quotas': payedQuotas,
      'currency_type': currencyType.value,
      'name': name,
      'type': type.value,
      'fixed_expense': fixedExpense,
      'financial_entity_id': financialEntityId,
    };
  }

  PurchaseHomeDto copyWith({
    int? id,
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
    bool? fixedExpense,
    int? financialEntityId,
  }) {
    return PurchaseHomeDto(
      id: id ?? this.id,
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
      fixedExpense: fixedExpense ?? this.fixedExpense,
      financialEntityId: financialEntityId ?? this.financialEntityId,
    );
  }
}
