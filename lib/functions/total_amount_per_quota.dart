import 'package:purchase_manager/models/enums/exchange_rate.dart';
import 'package:purchase_manager/models/financial_entity.dart';

double totalAmountPerQuota(
    {required List<FinancialEntity> categories, required int dollarValue}) {
  double totalAmountPerQuota = 0;

  for (var category in categories) {
    for (var purchase in category.purchases) {
      totalAmountPerQuota += purchase.currency == Currency.usDollar
          ? purchase.amountPerQuota * dollarValue
          : purchase.amountPerQuota;
    }
  }

  return totalAmountPerQuota;
}
