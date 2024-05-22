import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Calcula el monto total de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmount({
  required List<FinancialEntity> financialEntityList,
  required FeatureType financialEntityType,
  required int dollarValue,
}) {
  return financialEntityList.isEmpty
      ? 0
      : financialEntityList
          .expand((category) => category.purchases)
          .where(
            (purchases) => financialEntityType.getBooleanValue(
              financialEntityType,
              purchases,
            ),
          )
          .fold<double>(
            0,
            (accumulated, purchase) =>
                accumulated +
                (purchase.currency == CurrencyType.usDollar
                    ? purchase.totalAmount * dollarValue
                    : purchase.totalAmount),
          );
}
