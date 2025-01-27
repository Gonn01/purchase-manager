import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/functions/share_result.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogDeleteFinancialEntity}
/// DialDialogogo para eliminar una entidad financiera
///
/// Dialog to delete a financial entity
/// {@endtemplate}
class DialogPayMonthAlert extends StatelessWidget {
  /// {@macro DialogDeleteFinancialEntity}
  const DialogPayMonthAlert({
    required this.financialEntity,
    required this.purchaseList,
    super.key,
  });

  /// Entidad financiera a eliminar
  final FinancialEntity financialEntity;

  /// Lista de compras a pagar
  final List<Purchase> purchaseList;

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      onTapConfirm: () {
        final state = context.read<BlocDashboard>().state;
        context.read<BlocDashboard>().add(
              BlocDashboardEventPayMonth(
                purchaseList: purchaseList,
                idFinancialEntity: financialEntity.id,
              ),
            );
        onShareWithResult(
          context: context,
          financialEntityName: financialEntity.name,
          purchases: purchaseList,
          total: state.selectedCurrency.totalAmountPerFinancialEntity(
            purchases: purchaseList,
            currency: state.currency,
          ),
          currency: state.currency,
          currencyType: state.selectedCurrency,
        );
        Navigator.of(context).pop();
      },
      content: const Text('¿Estas seguro que queres pagar el mes?'),
      title: 'Pagar mes',
      isEnabled: true,
    );
  }
}
