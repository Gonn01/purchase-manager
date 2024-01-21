import 'package:purchase_manager/models/enums/currency_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmountPerQuota({
  required List<FinancialEntity> categories,
  required int dollarValue,
}) {
  // ignore: omit_local_variable_types
  double totalAmountPerQuota = 0;

  for (final category in categories) {
    for (final purchase in category.purchases) {
      totalAmountPerQuota += (purchase.currency == CurrencyType.usDollar
          ? purchase.amountPerQuota * dollarValue
          : purchase.amountPerQuota);
    }
  }

  return totalAmountPerQuota;
}
