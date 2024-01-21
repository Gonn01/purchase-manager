import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/extensions/string.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/purchase_element.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

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
        BlocBuilder<BlocHome, BlocHomeState>(
          builder: (context, state) {
            List<Purchase> listaCompras(BlocHomeState state) {
              switch (featureType) {
                case FeatureType.currentDebtor:
                  return state.listPurchaseStatusCurrentDebtor(financialEntity);
                case FeatureType.currentCreditor:
                  return state
                      .listPurchaseStatusCurrentCreditor(financialEntity);
                case FeatureType.settledDebtor:
                  return state.listPurchaseStatusSettledDebtor(financialEntity);
                case FeatureType.settledCreditor:
                  return state
                      .listPurchaseStatusSettledCreditor(financialEntity);
                // ignore: no_default_cases
                default:
                  return [];
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: listaCompras(state)
                    .map(
                      (purchase) => PurchaseElement(
                        purchase: purchase,
                        financialEntity: financialEntity,
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
