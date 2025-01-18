// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/purchase_element.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
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

  /// Lista de compras a mostrar dependiendo del tipo de feature
  ///
  /// List of purchases to show depending on the type of feature
  List<Purchase> purchaseList(BlocHomeState state) {
    switch (featureType) {
      case FeatureType.currentDebtor:
        return state.listPurchaseStatusCurrentDebtor(financialEntity);
      case FeatureType.currentCreditor:
        return state.listPurchaseStatusCurrentCreditor(financialEntity);
      case FeatureType.settledDebtor:
        return state.listPurchaseStatusSettledDebtor(financialEntity);
      case FeatureType.settledCreditor:
        return state.listPurchaseStatusSettledCreditor(financialEntity);
      // ignore: no_default_cases
      default:
        return [];
    }
  }

  /// Genera el texto a enviar por whatsapp
  ///
  /// Generates the text to send by whatsapp
  String generateText({
    required String financialEntityName,
    required List<Purchase> purchases,
  }) {
    final buffer = StringBuffer()..write('$financialEntityName: \n');
    for (final purchase in purchases) {
      buffer.write(
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.toStringAsFixed(2)}\n'
        'Cuota ${purchase.quotasPayed + 1}/${purchase.amountOfQuotas}\n',
      );
    }
    buffer.write(
      'Total: \$${purchases.fold<double>(0, (previousValue, element) => previousValue + element.amountPerQuota).toStringAsFixed(2)}',
    );
    return buffer.toString();
  }

  /// Entidad financiera a mostrar
  ///
  /// Financial entity to show
  final FinancialEntity financialEntity;

  /// Tipo de feature a mostrar
  ///
  /// Type of feature to show
  final FeatureType featureType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        return ExpansionTile(
          collapsedBackgroundColor: featureType == FeatureType.currentDebtor
              ? const Color(0xff02B3A3)
              : const Color(0xff006255),
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
                children: purchaseList(state)
                    .map(
                      (purchase) => PurchaseElement(
                        purchase: purchase,
                        financialEntity: financialEntity,
                        featureType: featureType,
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
                    'Total de este mes \$${state.totalAmountPerMonth(purchases: state.listPurchaseStatusCurrentDebtor(financialEntity)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onShareWithResult(
                        context,
                        financialEntity.name,
                        purchaseList(state),
                      );
                    },
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
                  // context.read<BlocHome>().add(BlocHomeEventPayMonth(purchase: '', idFinancialEntity: ''));
                },
                child: const Text(
                  'Pagar este mes',
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
  ) async {
    final box = context.findRenderObject() as RenderBox?;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ShareResult shareResult;

    shareResult = await Share.share(
      generateText(
        financialEntityName: financialEntityName,
        purchases: purchases,
      ),
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Share result: ${result.status}'),
          if (result.status == ShareResultStatus.success)
            Text('Shared to: ${result.raw}'),
        ],
      ),
    );
  }
}
