import 'package:purchase_manager/models/purchase.dart';

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
}
