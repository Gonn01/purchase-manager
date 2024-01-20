import 'package:purchase_manager/extensions/string.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/purchase_element.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:purchase_manager/models/financial_entity_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialEntityElement extends StatelessWidget {
  const FinancialEntityElement({
    required this.financialEntity,
    required this.financialEntityType,
    super.key,
  });
  final FinancialEntity financialEntity;
  final FinancialEntityType financialEntityType;

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
        BlocBuilder<BlocDashboard, BlocDashboardState>(
          builder: (context, state) {
            List<Purchase> listaCompras(BlocDashboardState state) {
              switch (financialEntityType) {
                case FinancialEntityType.currentDebtor:
                  return state.listPurchaseStatusCurrentDebt(financialEntity);
                case FinancialEntityType.currentCreditor:
                  return state.listPurchaseStatusCurrentDebtor(financialEntity);
                case FinancialEntityType.settledDebtor:
                  return state.listPurchaseStatusHistoryDebt(financialEntity);
                case FinancialEntityType.settledCreditor:
                  return state.listPurchaseStatusHistoryDebtor(financialEntity);
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listaCompras(state)
                    .map((purchase) => PurchaseElement(
                          purchase: purchase,
                          financialEntity: financialEntity,
                        ))
                    .toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
