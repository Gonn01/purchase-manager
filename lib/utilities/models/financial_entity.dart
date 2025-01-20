import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template FinancialEntity}
/// Entidad financiera que contiene las compras
///
/// Financial entity that contains purchases
/// {@endtemplate}
class FinancialEntity {
  /// {@macro FinancialEntity}
  const FinancialEntity({
    required this.id,
    required this.name,
    required this.purchases,
    required this.logs,
  });

  /// id de la entidad financiera
  ///
  /// id of the financial entity
  final String id;

  /// Nombre de la entidad financiera
  ///
  /// Name of the financial entity
  final String name;

  /// Compras de la entidad financiera
  ///
  /// Purchases of the financial entity
  final List<Purchase> purchases;

  /// Logs de la entidad financiera
  ///
  /// Logs of the financial entity
  final List<String> logs;

  /// Copia de la entidad financiera con los nuevos valores
  ///
  /// Copy of the financial entity with the new values
  FinancialEntity copyWith({
    String? id,
    String? name,
    List<Purchase>? purchases,
    List<String>? logs,
  }) {
    return FinancialEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      purchases: purchases ?? this.purchases,
      logs: logs ?? this.logs,
    );
  }
}
