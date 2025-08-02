import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';

class FinancialEntityPurchaseDto {
  FinancialEntityPurchaseDto({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.type,
  });

  factory FinancialEntityPurchaseDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityPurchaseDto(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: PurchaseType.type(json['type'] as int),
    );
  }

  final int id;
  final String name;
  final DateTime createdAt;
  final PurchaseType type;
}
