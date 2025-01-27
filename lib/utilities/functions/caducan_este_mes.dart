import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';

int caducanEsteMes({required List<FinancialEntity> financialEntities}) {
  var count = 0;

  for (final financialEntity in financialEntities) {
    final purchases = financialEntity.purchases.where(
      (p) =>
          !p.ignored &&
          (p.type == PurchaseType.currentDebtorPurchase ||
              p.type == PurchaseType.currentCreditorPurchase),
    );
    for (final purchase in purchases) {
      if (purchase.amountOfQuotas - purchase.quotasPayed == 1) {
        count++;
      }
    }
  }

  return count;
}
