// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/extensions/string.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/purchase_element.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:url_launcher/url_launcher.dart';

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
        '${purchase.nameOfProduct}: \$${purchase.amountPerQuota.toStringAsFixed(2)}\n',
      );
    }
    buffer.write(
      'Total: \$${purchases.fold<double>(0, (previousValue, element) => previousValue + element.amountPerQuota)}',
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
    final auth = FirebaseAuth.instance;

    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
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
                children: purchaseList(state)
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
                    'Total de este mes \$${state.totalAmountPerMonth(purchases: state.listPurchaseStatusCurrentDebtor(financialEntity)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => launchUrl(
                      Uri.parse(
                        'https://wa.me/${auth.currentUser?.phoneNumber}?text=${generateText(financialEntityName: financialEntity.name, purchases: purchaseList(state))}'
                            .replaceAll(' ', '%20'),
                      ),
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
          ],
        );
      },
    );
  }
}
