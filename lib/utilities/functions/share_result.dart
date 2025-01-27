import 'package:flutter/material.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:share_plus/share_plus.dart';

/// Comparte el texto generado con el usuario
///
/// Shares the generated text with the user
Future<void> onShareWithResult({
  required BuildContext context,
  required String financialEntityName,
  required List<Purchase> purchases,
  required double total,
  required Currency currency,
  required CurrencyType selectedCurrency,
}) async {
  final box = context.findRenderObject() as RenderBox?;
  // await Clipboard.setData(
  //   ClipboardData(
  //     text: generateText(
  //       financialEntityName: financialEntityName,
  //       purchases: purchases,
  //       total: total,
  //       dollarValue: dollarValue,
  //     ),
  //   ),
  // );

  await Share.share(
    selectedCurrency.generateText(
      financialEntityName: financialEntityName,
      purchases: purchases,
      total: total,
      currency: currency,
      selectedCurrency: selectedCurrency,
    ),
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}
