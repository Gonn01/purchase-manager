import 'package:purchase_manager/models/enums/exchange_rate.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';

double totalAmount({
  required List<FinancialEntity> categoriesList,
  required FeatureType financialEntityType,
  required int dollarValue,
}) {
  return categoriesList.isEmpty
      ? 0
      : categoriesList
          .expand((category) => category.purchases)
          .where((purchases) => financialEntityType.getBooleanValue(
              financialEntityType, purchases))
          .fold<double>(
            0,
            (accumulated, purchase) =>
                accumulated +
                (purchase.currency == Currency.usDollar
                    ? purchase.totalAmount * dollarValue
                    : purchase.totalAmount),
          );
}
