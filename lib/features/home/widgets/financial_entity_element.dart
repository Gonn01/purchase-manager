// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/purchase_element.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_financial_entity.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:share_plus/share_plus.dart';

/// {@template FinancialEntityElement}
/// Elemento que muestra los datos de una [FinancialEntity]
///
/// Element that shows the data of a [FinancialEntity]
/// {@endtemplate}
class FinancialEntityElement extends StatelessWidget {
  /// {@macro FinancialEntityElement}
  const FinancialEntityElement({
    required this.financialEntity,
    required this.featureType,
    super.key,
  });

  /// Genera el texto a enviar por whatsapp
  ///
  /// Generates the text to send by whatsapp
  String generateText({
    required String financialEntityName,
    required List<Purchase> purchases,
    required String total,
    required int dollarValue,
  }) {
    final purchasesCreditor = purchases.where(
      (purchase) => purchase.type == PurchaseType.currentCreditorPurchase,
    );

    final purchasesDebtor = purchases.where(
      (purchase) => purchase.type == PurchaseType.currentDebtorPurchase,
    );

    final thereIsPurchasesInDollars = purchasesCreditor.any(
          (purchase) => purchase.currency == CurrencyType.usDollar,
        ) ||
        purchasesDebtor.any(
          (purchase) => purchase.currency == CurrencyType.usDollar,
        );

    final totalCreditor = purchasesCreditor.fold<double>(
      0,
      (previousValue, purchase) =>
          previousValue +
          (purchase.currency == CurrencyType.usDollar
              ? purchase.amountPerQuota * dollarValue
              : purchase.amountPerQuota),
    );

    final totalDebtor = purchasesDebtor.fold<double>(
      0,
      (previousValue, purchase) =>
          previousValue +
          (purchase.currency == CurrencyType.usDollar
              ? purchase.amountPerQuota * dollarValue
              : purchase.amountPerQuota),
    );

    final buffer = StringBuffer()
      ..write('$financialEntityName: \n\n')
      ..write('Te debo:\n\n');
    for (final purchase in purchasesDebtor) {
      buffer.write(
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.toStringAsFixed(2)} ${purchase.currency.name}\n'
        'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }
    buffer.write('Me debes:\n\n');

    for (final purchase in purchasesCreditor) {
      buffer.write(
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.toStringAsFixed(2)} ${purchase.currency.name}\n'
        'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }

    buffer
      ..write(thereIsPurchasesInDollars ? 'Dolar: \$$dollarValue\n\n' : '')
      ..write(
        'Total: \$$total (${totalDebtor.toStringAsFixed(2)} - ${totalCreditor.toStringAsFixed(2)})',
      );
    return buffer.toString();
  }

  /// Entidad financiera a mostrar
  ///
  /// Financial entity to show
  final FinancialEntity financialEntity;

  /// Tipo de característica
  final FeatureType featureType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocHome, BlocHomeState>(
      listener: (context, state) {
        if (state is BlocHomeStateSuccessPayingMonth) {
          var lista = <Purchase>[];
          if (featureType == FeatureType.settled) {
            lista = state.listPurchaseStatusSettled(financialEntity);
          } else {
            lista = state.listPurchaseStatusCurrent(financialEntity);
          }
          _onShareWithResult(
            context,
            financialEntity.name,
            lista,
            totalAmountPerFinancialEntity(
              purchases: lista,
              dollarValue: state.currency?.venta ?? 0,
            ).toStringAsFixed(2),
            state.currency?.venta ?? 0,
          );
        }
      },
      builder: (context, state) {
        var lista = <Purchase>[];
        if (featureType == FeatureType.settled) {
          lista = state.listPurchaseStatusSettled(financialEntity);
        } else {
          lista = state.listPurchaseStatusCurrent(financialEntity);
        }
        return ExpansionTile(
          collapsedBackgroundColor: const Color(0xff02B3A3),
          title: Text(
            financialEntity.name.capitalize,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xff006255),
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: lista
                    .map(
                      (purchase) => PurchaseElement(
                        purchase: purchase,
                        financialEntity: financialEntity,
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total de este mes \$${totalAmountPerFinancialEntity(
                      purchases: lista,
                      dollarValue: state.currency?.venta ?? 0,
                    ).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onShareWithResult(
                      context,
                      financialEntity.name,
                      lista,
                      totalAmountPerFinancialEntity(
                        purchases: lista,
                        dollarValue: state.currency?.venta ?? 0,
                      ).toStringAsFixed(2),
                      state.currency?.venta ?? 0,
                    ),
                    child: Image.asset(
                      Assets.icons.whatsapp.path,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  context.read<BlocHome>().add(
                        BlocHomeEventPayMonth(
                          purchaseList: lista,
                          idFinancialEntity: financialEntity.id,
                        ),
                      );
                },
                child: const Text(
                  'Pagar este mes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onShareWithResult(
    BuildContext context,
    String financialEntityName,
    List<Purchase> purchases,
    String total,
    int dollarValue,
  ) async {
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
      generateText(
        financialEntityName: financialEntityName,
        purchases: purchases,
        total: total,
        dollarValue: dollarValue,
      ),
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
