import 'package:purchase_manager/extensions/double.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/financial_entity_element.dart';
import 'package:purchase_manager/functions/total_amount.dart';
import 'package:purchase_manager/functions/total_amount_per_quota.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCreditorCurrentPurchases extends StatelessWidget {
  const ViewCreditorCurrentPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xff02B3A3),
          ));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Me deben en total: ${totalAmount(
                  categoriesList:
                      state.listFinancialEntityStatusCurrentCreditor,
                  financialEntityType: FeatureType.currentCreditor,
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
                'Total que me deben por mes: ${totalAmountPerQuota(
                  categories: state.listFinancialEntityStatusCurrentCreditor,
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
                children: state.listFinancialEntityStatusCurrentCreditor
                    .map(
                      (categoria) => categoria.purchases.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: FinancialEntityElement(
                                financialEntity: categoria,
                                featureType: FeatureType.currentCreditor,
                              ),
                            )
                          : Container(),
                    )
                    .toList(),
              ),
            )
          ],
        );
      },
    );
  }
}
