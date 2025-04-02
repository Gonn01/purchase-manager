import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';

int caducanEsteMes({required List<FinancialEntity> financialEntities}) {
  var count = 0;

  for (final financialEntity in financialEntities) {
    final purchases = financialEntity.purchases.where(
      (p) =>
          !p.ignored &&
          !p.fixedExpense &&
          (p.type == PurchaseType.currentDebtorPurchase ||
              p.type == PurchaseType.currentCreditorPurchase),
    );
    for (final purchase in purchases) {
      if (purchase.numberOfQuotas - purchase.payedQuotas == 1) {
        count++;
      }
    }
  }

  return count;
}

double caducanEsteMesDinero({
  required List<FinancialEntity> financialEntities,
  required Currency currency,
  required CurrencyType selectedCurrency,
}) {
  var count = 0.0;

  for (final financialEntity in financialEntities) {
    final purchases = financialEntity.purchases
        .where(
          (p) =>
              !p.ignored &&
              !p.fixedExpense &&
              (p.type == PurchaseType.currentDebtorPurchase ||
                  p.type == PurchaseType.currentCreditorPurchase) &&
              p.numberOfQuotas - p.payedQuotas == 1,
        )
        .toList();
    count += selectedCurrency.totalAmountPerFinancialEntity(
      purchases: purchases,
      currency: currency,
    );
  }

  return count;
}
