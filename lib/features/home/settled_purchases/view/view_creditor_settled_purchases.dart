import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/financial_entity_element.dart';
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
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        return ListView(
          children: state.listFinancialEntityStatusSettledCreditor
              .map(
                (financialEntity) => financialEntity.purchases.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: FinancialEntityElement(
                          financialEntity: financialEntity,
                          featureType: FeatureType.settledCreditor,
                        ),
                      )
                    : Container(),
              )
              .toList(),
        );
      },
    );
  }
}
