import 'package:purchase_manager/models/purchase.dart';

class FinancialEntity {
  const FinancialEntity({
    required this.id,
    required this.name,
    required this.purchases,
  });
  final String id;
  final String name;
  final List<Purchase> purchases;
}
