import 'package:purchase_manager/features/dashboard/financial_entity_details/dtos/financial_entity_log_dto.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_details/dtos/financial_entity_purchase_dto.dart';

class FinancialEntityDetailsDto {
  /// Constructor for [FinancialEntityDetailsDto]
  const FinancialEntityDetailsDto({
    required this.id,
    required this.name,
    required this.purchases,
    required this.logs,
  });

  factory FinancialEntityDetailsDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityDetailsDto(
      id: json['id'] as int,
      name: json['name'] as String,
      purchases: (json['purchases'] as List<dynamic>)
          .map((purchase) => FinancialEntityPurchaseDto.fromJson(
              purchase as Map<String, dynamic>))
          .toList(),
      logs: (json['logs'] as List<dynamic>)
          .map((log) =>
              FinancialEntityLogDto.fromJson(log as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Unique identifier of the financial entity
  final int id;

  /// Name of the financial entity
  final String name;
  final List<FinancialEntityPurchaseDto> purchases;
  final List<FinancialEntityLogDto> logs;
}
