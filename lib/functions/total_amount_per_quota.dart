import 'package:purchase_manager/models/financial_entity.dart';

double totalAmountPerQuota({required List<FinancialEntity> categories}) {
  double totalAmountPerQuota = 0;

  for (var category in categories) {
    for (var purchase in category.purchases) {
      totalAmountPerQuota += purchase.amountPerQuota;
    }
  }

  return totalAmountPerQuota;
}
