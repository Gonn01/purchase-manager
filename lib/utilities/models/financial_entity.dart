// ignore_for_file: public_member_api_docs

import 'package:purchase_manager/utilities/models/logs.dart';
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
    required this.createdAt,
    required this.name,
    required this.deleted,
    required this.purchases,
    required this.logs,
  });

  /// Crea una [FinancialEntity] a partir de un json
  ///
  /// Create a [FinancialEntity] from a json
  factory FinancialEntity.fromJson(Map<String, dynamic> json) {
    return FinancialEntity(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      deleted: json['deleted'] as bool,
      purchases: (json['purchases'] as List)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
      logs: json['logs'] != null
          ? (json['logs'] as List)
              .map(
                (e) => FinancialEntityLog.fromJson(e as Map<String, dynamic>),
              )
              .toList()
          : [],
    );
  }

  /// id de la entidad financiera
  ///
  /// id of the financial entity
  final int id;
  final DateTime createdAt;

  /// Nombre de la entidad financiera
  ///
  /// Name of the financial entity
  final String name;
  final bool deleted;

  /// Compras de la entidad financiera
  ///
  /// Purchases of the financial entity
  final List<Purchase> purchases;

  /// Logs de la entidad financiera
  ///
  /// Logs of the financial entity
  final List<FinancialEntityLog> logs;

  /// Copia de la entidad financiera con los nuevos valores
  ///
  /// Copy of the financial entity with the new values
  FinancialEntity copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    bool? deleted,
    List<Purchase>? purchases,
    List<FinancialEntityLog>? logs,
  }) {
    return FinancialEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      deleted: deleted ?? this.deleted,
      purchases: purchases ?? this.purchases,
      logs: logs ?? this.logs,
    );
  }
}
