import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/financial_entity_element.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

/// {@template ViewCreditorSettledPurchases}
/// Vista de las compras liquidadas acreedoras
/// View of settled creditor purchases
/// {@endtemplate}
class ViewCreditorSettledPurchases extends StatelessWidget {
  /// {@macro ViewCreditorSettledPurchases}
  const ViewCreditorSettledPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BlocDashboard, BlocDashboardState>(
        builder: (context, state) {
          return Column(
            children: state.listFinancialEntityStatusSettledCreditor
                .map(
                  (categoria) => categoria.purchases.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: FinancialEntityElement(
                            financialEntity: categoria,
                            featureType: FeatureType.settledCreditor,
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
