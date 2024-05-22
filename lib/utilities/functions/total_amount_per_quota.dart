import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmountPerQuota({
  required List<FinancialEntity> financialEntities,
  required int dollarValue,
  required BlocHomeState state,
}) {
  // ignore: omit_local_variable_types
  double totalAmountPerQuota = 0;

  for (final category in financialEntities) {
    for (final purchase in state.listPurchaseStatusCurrentDebtor(category)) {
      totalAmountPerQuota += (purchase.currency == CurrencyType.usDollar
          ? purchase.amountPerQuota * dollarValue
          : purchase.amountPerQuota);
    }
  }

  return totalAmountPerQuota;
}
