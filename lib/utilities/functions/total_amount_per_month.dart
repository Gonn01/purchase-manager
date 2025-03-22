import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity].
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity].
double totalAmountPerMonthPesos({
  required List<FinancialEntity> financialEntities,
  required Currency currency,
}) {
  var monto = 0.0;

  final purchases = financialEntities.expand((category) => category.purchases);

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;

  final euroValue = currency.euroBlue.valueSell;

  for (final purchase in ps) {
    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.usDollar) {
        monto -= amount * dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto -= amount * euroValue;
      } else {
        monto -= amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.usDollar) {
        monto += amount * dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto += amount * euroValue;
      } else {
        monto += amount;
      }
    }
  }
  return monto;
}

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity] en dólares.
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity] in USD.
double totalAmountPerMonthDolar({
  required List<FinancialEntity> financialEntities,
  required Currency currency,
}) {
  var monto = 0.0;

  final purchases = financialEntities.expand((category) => category.purchases);

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;
  final euroValue = currency.euroBlue.valueSell;

  for (final purchase in ps) {
    final amount = purchase.amountPerQuota;

    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto -= amount / dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto -= (amount * euroValue) / dollarValue;
      } else {
        monto -= amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto += amount / dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto += (amount * euroValue) / dollarValue;
      } else {
        monto += amount;
      }
    }
  }
  return monto;
}

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity] en euros.
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity] in EUR.
double totalAmountPerMonthEuro({
  required List<FinancialEntity> financialEntities,
  required Currency currency,
}) {
  var monto = 0.0;

  final purchases = financialEntities.expand((category) => category.purchases);

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;
  final euroValue = currency.euroBlue.valueSell;

  for (final purchase in ps) {
    final amount = purchase.amountPerQuota;

    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto -= amount / euroValue;
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        monto -= (amount * dollarValue) / euroValue;
      } else {
        monto -= amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto += amount / euroValue;
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        monto += (amount * dollarValue) / euroValue;
      } else {
        monto += amount;
      }
    }
  }
  return monto;
}
