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
double totalAmountPerFinancialEntityPesos({
  required Currency currency,
  required List<Purchase> purchases,
}) {
  var monto = 0.0;

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;

  for (final purchase in ps) {
    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.usDollar) {
        monto += amount * dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto += amount * currency.euroBlue.valueSell;
      } else {
        monto += amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.usDollar) {
        monto -= amount * dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto -= amount * currency.euroBlue.valueSell;
      } else {
        monto -= amount;
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
double totalAmountPerFinancialEntityDolar({
  required Currency currency,
  required List<Purchase> purchases,
}) {
  var monto = 0.0;

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;

  final euroValue = currency.euroBlue.valueSell;

  for (final purchase in ps) {
    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto += amount / dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto += (amount * euroValue) / dollarValue;
      } else {
        monto += amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto -= amount / dollarValue;
      } else if (purchase.currencyType == CurrencyType.euro) {
        monto -= (amount * euroValue) / dollarValue;
      } else {
        monto -= amount;
      }
    }
  }
  return monto;
}

/// Calcula el monto total por cuota de todas las [Purchase] de una lista de
/// [FinancialEntity] en euros.
///
/// Calculates the total amount per quota of all the [Purchase] of a list of
/// [FinancialEntity] in euros.
double totalAmountPerFinancialEntityEuro({
  required Currency currency,
  required List<Purchase> purchases,
}) {
  var monto = 0.0;

  final ps = purchases.where((p) => !p.ignored);

  final dollarValue = currency.dolarBlue.valueSell;

  final euroValue = currency.euroBlue.valueSell;

  for (final purchase in ps) {
    if (purchase.purchaseType == PurchaseType.currentDebtorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto += amount / euroValue;
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        monto += (amount * dollarValue) / euroValue;
      } else {
        monto += amount;
      }
    } else if (purchase.purchaseType == PurchaseType.currentCreditorPurchase) {
      final amount = purchase.amountPerQuota;
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        monto -= amount / euroValue;
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        monto -= (amount * dollarValue) / euroValue;
      } else {
        monto -= amount;
      }
    }
  }
  return monto;
}
