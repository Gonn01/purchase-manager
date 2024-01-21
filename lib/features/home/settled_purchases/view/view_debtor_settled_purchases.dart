import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

/// {@template ViewDebtorSettledPurchases}
/// Vista de las compras liquidadas deudoras
///
/// View of settled debtor purchases
/// {@endtemplate}
class ViewDebtorSettledPurchases extends StatelessWidget {
  /// {@macro ViewDebtorSettledPurchases}
  const ViewDebtorSettledPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BlocHome, BlocHomeState>(
        builder: (context, state) {
          return Column(
            children: state.listFinancialEntityStatusSettledDebtor
                .map(
                  (categoria) => categoria.purchases.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: FinancialEntityElement(
                            financialEntity: categoria,
                            featureType: FeatureType.settledDebtor,
                          ),
                        )
                      : Container(),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
