import 'package:purchase_manager/models/purchase.dart';

enum FinancialEntityType {
  currentDebtor,
  currentCreditor,
  settledDebtor,
  settledCreditor;

  bool getBooleanValue(FinancialEntityType type, Purchase purchase) {
    switch (type) {
      case FinancialEntityType.currentDebtor:
        return purchase.current && purchase.debt;
      case FinancialEntityType.currentCreditor:
        return purchase.current && !purchase.debt;
      case FinancialEntityType.settledDebtor:
        return !purchase.current && purchase.debt;
      case FinancialEntityType.settledCreditor:
        return !purchase.current && !purchase.debt;
    }
  }
}
