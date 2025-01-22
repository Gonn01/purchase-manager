import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Calcula el monto total de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmount({
  required List<FinancialEntity> financialEntityList,
  required int dollarValue,
}) {
  var monto = 0.0;
  final purchases =
      financialEntityList.expand((category) => category.purchases);

  final ps = purchases.where((p) => !p.ignored);
  for (final purchase in ps) {
    if (purchase.type == PurchaseType.currentDebtorPurchase) {
      final amount = (purchase.amountOfQuotas - purchase.quotasPayed) *
          purchase.amountPerQuota;
      if (purchase.currency == CurrencyType.usDollar) {
        monto -= amount * dollarValue;
      } else {
        monto -= amount;
      }
    } else if (purchase.type == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountOfQuotas * purchase.amountPerQuota;
      if (purchase.currency == CurrencyType.usDollar) {
        monto += amount * dollarValue;
      } else {
        monto += amount;
      }
    }
  }
  return monto;
}
