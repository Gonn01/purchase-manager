// ignore_for_file: lines_longer_than_80_chars a

import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// Genera el texto a enviar por whatsapp
///
/// Generates the text to send by whatsapp
String generateText2({
  required String financialEntityName,
  required List<Purchase> purchases,
  required double total,
  required Currency currency,
  required CurrencyType selectedCurrency,
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

  final totalCreditor = selectedCurrency.totalCreditor(
    purchases: purchasesCreditor.toList(),
    currency: currency,
  );

  final totalDebtor = selectedCurrency.totalDebtor(
    purchases: purchasesDebtor.toList(),
    currency: currency,
  );

  final buffer = StringBuffer()..write('$financialEntityName: \n\n');

  if (purchasesDebtor.isNotEmpty) {
    buffer.write('*Te debo (${selectedCurrency.abreviation}):*\n\n');
    for (final purchase in purchasesDebtor) {
      buffer.write(
        selectedCurrency.textoParaCards(
          purchase: purchase,
          currency: currency,
        ),
      );
    }
    buffer.write(
      'En total te debo: ${totalDebtor.formatAmount} ${selectedCurrency.abreviation}\n\n\n',
    );
  }

  if (purchasesCreditor.isNotEmpty) {
    buffer.write('*Me debes (${selectedCurrency.abreviation}):*\n\n');
    for (final purchase in purchasesCreditor) {
      buffer.write(
        selectedCurrency.textoParaCards(
          purchase: purchase,
          currency: currency,
        ),
      );
    }
    buffer.write(
      'En total me debes: ${totalCreditor.formatAmount} ${selectedCurrency.abreviation}\n\n\n',
    );
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
      '${(total.isNegative ? (total * -1) : total).formatAmount} ${selectedCurrency.abreviation}');

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
