import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmountPerFinancialEntity({
  required int dollarValue,
  required List<Purchase> purchases,
}) {
  var monto = 0.0;

  for (final purchase in purchases) {
    if (purchase.type == PurchaseType.currentDebtorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currency == CurrencyType.usDollar) {
        monto += amount * dollarValue;
      } else {
        monto += amount;
      }
    } else if (purchase.type == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currency == CurrencyType.usDollar) {
        monto -= amount * dollarValue;
      } else {
        monto -= amount;
      }
    }
  }
  return monto;
}
