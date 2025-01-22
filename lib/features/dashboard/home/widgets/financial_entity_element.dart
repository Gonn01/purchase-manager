import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/purchase_element.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_financial_entity.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
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
    required this.index,
    super.key,
  });

  /// Genera el texto a enviar por whatsapp
  ///
  /// Generates the text to send by whatsapp
  String generateText({
    required String financialEntityName,
    required List<Purchase> purchases,
    required double total,
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
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.formatAmount} ${purchase.currency.name}\nCuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }
    buffer.write('Me debes:\n\n');

    for (final purchase in purchasesCreditor) {
      buffer.write(
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.formatAmount} ${purchase.currency.name}\nCuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n\n',
      );
    }

    buffer
      ..write(thereIsPurchasesInDollars ? 'Dolar: \$$dollarValue\n\n' : '')
      ..write(
        '${total.isNegative ? 'Me debes en' : 'Te debo en'} total: \$'
        '${total.formatAmount} (${totalDebtor.formatAmount} - '
        '${totalCreditor.formatAmount})',
      );
    return buffer.toString();
  }

  /// Entidad financiera a mostrar
  ///
  /// Financial entity to show
  final FinancialEntity financialEntity;

  /// Indice de la lista de entidades financieras
  ///
  /// Index of the financial entities list
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        var lista = <Purchase>[];
        if (index == 1) {
          lista = state.listPurchaseStatusSettled(financialEntity);
        } else {
          lista = state.listPurchaseStatusCurrent(financialEntity);
        }
        final total = totalAmountPerFinancialEntity(
          purchases: lista,
          dollarValue: state.currency?.venta ?? 0,
        );
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
            if (index == 0)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // ignore: lines_longer_than_80_chars asd
                      '${total.isNegative ? 'Me debe en' : 'Le debo en'} total \$${(total.isNegative ? total * -1 : total).formatAmount}',
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
                        ),
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
            if (index == 0)
              Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () {
                    context.read<BlocDashboard>().add(
                          BlocDashboardEventPayMonth(
                            purchaseList: lista,
                            idFinancialEntity: financialEntity.id,
                          ),
                        );
                    _onShareWithResult(
                      context,
                      financialEntity.name,
                      lista,
                      total,
                      state.currency?.venta ?? 0,
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
    double total,
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
