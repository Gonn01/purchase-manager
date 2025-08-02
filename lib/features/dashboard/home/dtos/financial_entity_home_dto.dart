import 'package:purchase_manager/features/dashboard/home/dtos/purchase_home_dto.dart';

/// Wrapper que extiende una FinancialEntity con sus compras
class FinancialEntityWithPurchasesDto {
  const FinancialEntityWithPurchasesDto({
    required this.id,
    required this.name,
    required this.currentPurchases,
    required this.settledPurchases,
  });

  factory FinancialEntityWithPurchasesDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityWithPurchasesDto(
      id: json['id'] as int,
      name: json['name'] as String,
      currentPurchases: (json['current_purchases'] as List<dynamic>)
          .map((e) => PurchaseHomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      settledPurchases: (json['settled_purchases'] as List<dynamic>)
          .map((e) => PurchaseHomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final int id;
  final String name;
  final List<PurchaseHomeDto> currentPurchases;
  final List<PurchaseHomeDto> settledPurchases;
}
