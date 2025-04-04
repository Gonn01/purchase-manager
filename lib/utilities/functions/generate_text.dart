import 'package:purchase_manager/utilities/extensions/double.dart';
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
                ? purchase.amountPerQuota * euroValue
                : purchase.amountPerQuota),
  );

  final totalDebtor = purchasesDebtor.fold<double>(
    0,
    (previousValue, purchase) =>
        previousValue +
        (purchase.currencyType == CurrencyType.usDollar
            ? purchase.amountPerQuota * dollarValue
            : purchase.currencyType == CurrencyType.euro
                ? purchase.amountPerQuota * euroValue
                : purchase.amountPerQuota),
  );

  final buffer = StringBuffer()..write('$financialEntityName: \n\n');

  if (purchasesDebtor.isNotEmpty) {
    buffer.write('*Te debo (ARS):*\n\n');
    for (final purchase in purchasesDebtor) {
      if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota * dollarValue).formatAmount} ARS (${purchase.amountPerQuota} USD)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota * euroValue).formatAmount} ARS (${purchase.amountPerQuota} EUR)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota} ${purchase.currencyType.abreviation}\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total te debo: ${totalDebtor.formatAmount} ARS\n\n\n',
    );
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (ARS):*\n\n');
    for (final purchase in purchasesCreditor) {
      if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota * dollarValue).formatAmount} ARS (${purchase.amountPerQuota} USD)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota * euroValue).formatAmount} ARS (${purchase.amountPerQuota} EUR)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota} ${purchase.currencyType.abreviation}\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write('En total me debes: $totalCreditor ARS\n\n\n');
  }

  if (thereIsPurchasesInDollars) {
    buffer.write(
      'Valor del dolar tomado: 1 USD = $dollarValue ARS\n\n\n',
    );
  }

  if (thereIsPurchasesInEUR) {
    buffer.write(
      'Valor del euro tomado: 1 EUR = $euroValue ARS\n\n\n',
    );
  }

  buffer.write(
      '${total.isNegative ? '*Resumen*: Me debes en' : 'Te debo en'} total: '
      '${total.isNegative ? (total * -1) : total} ARS');
  if (totalDebtor == 0 ||
      totalCreditor == 0.0 ||
      totalCreditor == 0 ||
      totalDebtor == 0.0) {
    return buffer.toString();
  }
  if (totalDebtor > totalCreditor) {
    buffer.write(
        ' (${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount}'
        ' - '
        '${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount})');
  } else {
    buffer.write(
        ' (${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount}'
        ' - '
        '${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount})');
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

  final thereIsPurchasesInPesos = purchasesCreditor.any(
        (purchase) => purchase.currencyType == CurrencyType.pesoArgentino,
      ) ||
      purchasesDebtor.any(
        (purchase) => purchase.currencyType == CurrencyType.pesoArgentino,
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
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.formatAmount} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * euroValue) / dollarValue).formatAmount} USD(${purchase.amountPerQuota} EUR)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / dollarValue).formatAmount} USD(${purchase.amountPerQuota} ARS)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total te debo: ${totalDebtor.formatAmount} USD\n\n\n',
    );
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (USD):*\n\n');
    for (final purchase in purchasesCreditor) {
      if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.formatAmount} USD\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * euroValue) / dollarValue).formatAmount} USD(${purchase.amountPerQuota} EUR)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / dollarValue).formatAmount} USD(${purchase.amountPerQuota} ARS)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
  }

  buffer.write(
    'En total me debes: ${totalCreditor.formatAmount} USD\n\n\n',
  );

  if (thereIsPurchasesInPesos) {
    buffer.write(
      'Valor del dolar tomado: 1 USD = $dollarValue ARS\n\n\n',
    );
  }

  if (thereIsPurchasesInEUR) {
    buffer.write(
      'Valor del euro tomado: 1 USD = ${(dollarValue / euroValue).formatAmount} EUR\n\n\n',
    );
  }

  buffer.write(
      '${total.isNegative ? '*Resumen*: Me debes en' : 'Te debo en'} total: '
      '${(total.isNegative ? (total * -1) : total).formatAmount} USD');
  if (totalDebtor == 0 ||
      totalCreditor == 0.0 ||
      totalCreditor == 0 ||
      totalDebtor == 0.0) {
    return buffer.toString();
  }
  if (totalDebtor > totalCreditor) {
    buffer.write(
        ' (${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount}'
        ' - '
        '${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount})');
  } else {
    buffer.write(
        ' (${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount}'
        ' - '
        '${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount})');
  }
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

  final thereIsPurchasesInDollars = purchasesCreditor.any(
        (purchase) => purchase.currencyType == CurrencyType.usDollar,
      ) ||
      purchasesDebtor.any(
        (purchase) => purchase.currencyType == CurrencyType.usDollar,
      );

  final thereIsPurchasesInPesos = purchasesCreditor.any(
        (purchase) => purchase.currencyType == CurrencyType.pesoArgentino,
      ) ||
      purchasesDebtor.any(
        (purchase) => purchase.currencyType == CurrencyType.pesoArgentino,
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
      if (purchase.currencyType == CurrencyType.pesoArgentino) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.formatAmount} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * dollarValue) / euroValue).formatAmount} EUR (${purchase.amountPerQuota} USD)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / euroValue).formatAmount} EUR (${purchase.amountPerQuota} ARS)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total te debo: €${totalDebtor.formatAmount} EUR\n\n\n',
    );
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (EUR):*\n\n');
    for (final purchase in purchasesCreditor) {
      if (purchase.currencyType == CurrencyType.euro) {
        buffer.write(
          '${purchase.nameOfProduct}: ${purchase.amountPerQuota.formatAmount} EUR\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else if (purchase.currencyType == CurrencyType.usDollar) {
        buffer.write(
          '${purchase.nameOfProduct}: ${((purchase.amountPerQuota * dollarValue) / euroValue).formatAmount} EUR (${purchase.amountPerQuota} USD)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      } else {
        buffer.write(
          '${purchase.nameOfProduct}: ${(purchase.amountPerQuota / euroValue).formatAmount} EUR (${purchase.amountPerQuota} ARS)\n'
          'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
        );
      }
    }
    buffer.write(
      'En total me debes: €${totalCreditor.formatAmount} EUR\n\n\n',
    );
  }

  if (thereIsPurchasesInPesos) {
    buffer.write(
      'Valor del dolar tomado: 1 EUR = $euroValue ARS\n\n\n',
    );
  }

  if (thereIsPurchasesInDollars) {
    buffer.write(
      'Valor del euro tomado: 1 EUR = ${(euroValue / dollarValue).formatAmount} USD\n\n\n',
    );
  }

  buffer.write(
      '${total.isNegative ? '*Resumen*: Me debes en' : 'Te debo en'} total: '
      '${(total.isNegative ? (total * -1) : total).formatAmount} USD');
  if (totalDebtor == 0 ||
      totalCreditor == 0.0 ||
      totalCreditor == 0 ||
      totalDebtor == 0.0) {
    return buffer.toString();
  }
  if (totalDebtor > totalCreditor) {
    buffer.write(
        ' (${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount}'
        ' - '
        '${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount})');
  } else {
    buffer.write(
        ' (${(totalCreditor.isNegative ? totalCreditor * -1 : totalCreditor).formatAmount}'
        ' - '
        '${(totalDebtor.isNegative ? totalDebtor * -1 : totalDebtor).formatAmount})');
  }
  return buffer.toString();
}
