// ignore_for_file: lines_longer_than_80_chars a

import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Genera el texto a enviar por whatsapp
///
/// Generates the text to send by whatsapp
String generateTextPesos({
  required String financialEntityName,
  required List<Purchase> purchases,
  required double total,
  required Currency currency,
}) {
  final dollarValue = currency.dolarBlue.valueSell;

  final eurValue = currency.euroBlue.valueSell;

  final purchasesCreditor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentCreditorPurchase &&
        !purchase.ignored,
  );

  final purchasesDebtor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentDebtorPurchase &&
        !purchase.ignored,
  );

  final thereIsPurchasesInDollars = purchasesCreditor.any(
        (purchase) => purchase.currencyType == CurrencyType.usDollar,
      ) ||
      purchasesDebtor.any(
        (purchase) => purchase.currencyType == CurrencyType.usDollar,
      );

  final thereIsPurchasesInEUR = purchasesCreditor.any(
        (purchase) => purchase.currencyType == CurrencyType.euro,
      ) ||
      purchasesDebtor.any(
        (purchase) => purchase.currencyType == CurrencyType.euro,
      );

  final totalCreditor = purchasesCreditor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.usDollar
            ? purchase.amountPerQuota * dollarValue
            : purchase.currencyType == CurrencyType.euro
                ? purchase.amountPerQuota * eurValue
                : purchase.amountPerQuota),
  );

  final totalDebtor = purchasesDebtor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.usDollar
            ? purchase.amountPerQuota * dollarValue
            : purchase.currencyType == CurrencyType.euro
                ? purchase.amountPerQuota * eurValue
                : purchase.amountPerQuota),
  );

  final buffer = StringBuffer()..write('$financialEntityName: \n\n');

  if (purchasesDebtor.isNotEmpty) {
    buffer.write('*Te debo:*\n\n');
    for (final purchase in purchasesDebtor) {
      buffer.write(
        '${purchase.nameOfProduct}: ${purchase.amountPerQuota} ${purchase.currencyType.abreviation}\nCuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }
    buffer.write('En total te debo: \$${totalDebtor.toStringAsFixed(2)}\n\n');
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes:*\n\n');
    for (final purchase in purchasesCreditor) {
      buffer.write(
        '${purchase.nameOfProduct}: ${purchase.amountPerQuota} ${purchase.currencyType.abreviation}\nCuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }
    buffer.write('En total me debes: \$$totalCreditor\n\n');
  }

  if (thereIsPurchasesInDollars) {
    buffer.write(
      thereIsPurchasesInDollars
          ? 'Valor del dolar tomado: \$$dollarValue\n\n'
          : '',
    );
  }

  if (thereIsPurchasesInEUR) {
    buffer.write(
      thereIsPurchasesInEUR ? 'Valor del euro tomado: \$$eurValue\n\n' : '',
    );
  }

  buffer.write(
      '${total.isNegative ? '*Resumen*: Me debes en' : 'Te debo en'} total: '
      '${total.isNegative ? (total * -1) : total}');

  if (purchasesCreditor.isNotEmpty) {
    buffer.write(' (${totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor}'
        ' - '
        '${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).toStringAsFixed(2)})');
  }
  return buffer.toString();
}

/// Genera el texto a enviar por whatsapp
///
/// Generates the text to send by whatsapp
String generateTextInDollars({
  required String financialEntityName,
  required List<Purchase> purchases,
  required double total,
  required Currency currency,
}) {
  final dollarValue = currency.dolarBlue.valueSell;

  final euroValue = currency.euroBlue.valueSell;

  final purchasesCreditor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentCreditorPurchase &&
        !purchase.ignored,
  );

  final purchasesDebtor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentDebtorPurchase &&
        !purchase.ignored,
  );

  final totalCreditor = purchasesCreditor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.usDollar
            ? purchase.amountPerQuota
            : purchase.currencyType == CurrencyType.euro
                ? (purchase.amountPerQuota * currency.euroBlue.valueSell) /
                    dollarValue
                : purchase.amountPerQuota / dollarValue),
  );

  final totalDebtor = purchasesDebtor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.usDollar
            ? purchase.amountPerQuota
            : purchase.currencyType == CurrencyType.euro
                ? (purchase.amountPerQuota * currency.euroBlue.valueSell) /
                    dollarValue
                : purchase.amountPerQuota / dollarValue),
  );

  final buffer = StringBuffer()..write('$financialEntityName: \n\n');

  if (purchasesDebtor.isNotEmpty) {
    buffer.write('*Te debo (USD):*\n\n');
    for (final purchase in purchasesDebtor) {
      if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * euroValue) / dollarValue).toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / dollarValue).toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer
        .write('En total te debo: \$${totalDebtor.toStringAsFixed(2)} USD\n\n');
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (USD):*\n\n');
    for (final purchase in purchasesCreditor) {
      if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * euroValue) / dollarValue).toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / dollarValue).toStringAsFixed(2)} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total me debes: \$${totalCreditor.toStringAsFixed(2)} USD\n\n',
    );
  }

  buffer.write('*Resumen:*'
      '${total.isNegative ? 'Me debes en' : 'Te debo en'} total: '
      '${total.isNegative ? (total * -1).toStringAsFixed(2) : total.toStringAsFixed(2)} USD '
      ' (${totalDebtor.isNegative ? (totalDebtor * -1).toStringAsFixed(2) : totalDebtor.toStringAsFixed(2)} - '
      '${totalCreditor.isNegative ? (totalCreditor * -1).toStringAsFixed(2) : totalCreditor.toStringAsFixed(2)})');

  return buffer.toString();
}

/// Genera el texto a enviar por whatsapp
///
/// Generates the text to send by whatsapp
String generateTextInEuros({
  required String financialEntityName,
  required List<Purchase> purchases,
  required double total,
  required Currency currency,
}) {
  final euroValue = currency.euroBlue.valueSell;

  final dollarValue = currency.dolarBlue.valueSell;

  final purchasesCreditor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentCreditorPurchase &&
        !purchase.ignored,
  );

  final purchasesDebtor = purchases.where(
    (purchase) =>
        purchase.type == PurchaseType.currentDebtorPurchase &&
        !purchase.ignored,
  );

  final totalCreditor = purchasesCreditor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.euro
            ? purchase.amountPerQuota
            : purchase.currencyType == CurrencyType.usDollar
                ? (purchase.amountPerQuota * currency.dolarBlue.valueSell) /
                    euroValue
                : purchase.amountPerQuota / euroValue),
  );

  final totalDebtor = purchasesDebtor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.euro
            ? purchase.amountPerQuota
            : purchase.currencyType == CurrencyType.usDollar
                ? (purchase.amountPerQuota * currency.dolarBlue.valueSell) /
                    euroValue
                : purchase.amountPerQuota / euroValue),
  );

  final buffer = StringBuffer()..write('$financialEntityName: \n\n');

  if (purchasesDebtor.isNotEmpty) {
    buffer.write('*Te debo (EUR):*\n\n');
    for (final purchase in purchasesDebtor) {
      if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * dollarValue) / euroValue).toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / euroValue).toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer
        .write('En total te debo: €${totalDebtor.toStringAsFixed(2)} EUR\n\n');
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (EUR):*\n\n');
    for (final purchase in purchasesCreditor) {
      if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * dollarValue) / euroValue).toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / euroValue).toStringAsFixed(2)} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total me debes: €${totalCreditor.toStringAsFixed(2)} EUR\n\n',
    );
  }

  buffer.write('*Resumen:*'
      '${total.isNegative ? 'Me debes en' : 'Te debo en'} total: '
      '${total.isNegative ? (total * -1).toStringAsFixed(2) : total.toStringAsFixed(2)} USD '
      ' (${totalDebtor.isNegative ? (totalDebtor * -1).toStringAsFixed(2) : totalDebtor.toStringAsFixed(2)} - '
      '${totalCreditor.isNegative ? (totalCreditor * -1).toStringAsFixed(2) : totalCreditor.toStringAsFixed(2)})');

  return buffer.toString();
}
