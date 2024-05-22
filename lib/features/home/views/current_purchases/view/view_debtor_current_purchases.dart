import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/functions/total_amount.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_quota.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:purchase_manager/utilities/models/enums/status.dart';

/// {@template ViewDebtorCurrentPurchases}
/// Vista de las compras vigentes deudoras
/// View of current debtor purchases
/// {@endtemplate}
class ViewDebtorCurrentPurchases extends StatelessWidget {
  /// {@macro ViewDebtorCurrentPurchases}
  const ViewDebtorCurrentPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Total adeudado: ${totalAmount(
                  financialEntityList:
                      state.listFinancialEntitiesStatusCurrentDebtor,
                  financialEntityType: FeatureType.currentDebtor,
                  dollarValue: state.currency?.venta ?? 0,
                ).formatAmount()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff047269),
                ),
              ),
            ),
            const Divider(
              height: .5,
              thickness: 3,
              color: Color(0xff02B3A3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Total adeudado por mes: ${totalAmountPerQuota(
                  state: state,
                  financialEntities:
                      state.listFinancialEntitiesStatusCurrentDebtor,
                  dollarValue: state.currency?.venta ?? 0,
                ).formatAmount()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff047269),
                ),
              ),
            ),
            const Divider(
              height: .5,
              thickness: 3,
              color: Color(0xff02B3A3),
            ),
            Expanded(
              child: ListView(
                children: state.listFinancialEntitiesStatusCurrentDebtor
                    .map(
                      (financialEntity) => financialEntity.purchases.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: FinancialEntityElement(
                                financialEntity: financialEntity,
                                featureType: FeatureType.currentDebtor,
                              ),
                            )
                          : Container(),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 60),
          ],
        );
      },
    );
  }
}
