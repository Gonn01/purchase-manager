import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/dtos/purchase_home_dto.dart';
import 'package:purchase_manager/utilities/functions/share_result.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogPayMonthAlert}
/// Dialogo para pagar el mes de una entidad financiera
///
/// Dialog to pay the month of a financial entity
/// {@endtemplate}
class DialogPayMonthAlert extends StatelessWidget {
  /// {@macro DialogPayMonthAlert}
  const DialogPayMonthAlert({
    required this.financialEntityId,
    required this.financialEntityName,
    required this.purchaseList,
    super.key,
  });

  /// Entidad financiera a eliminar
  final int financialEntityId;
  final String financialEntityName;

  /// Lista de compras a pagar
  final List<PurchaseHomeDto> purchaseList;

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      onTapConfirm: () {
        final state = context.read<BlocDashboard>().state;
        context.read<BlocHome>().add(
              BlocHomeEventPayMonth(
                purchaseList: purchaseList,
                idFinancialEntity: financialEntityId,
              ),
            );
        onShareWithResult(
          context: context,
          financialEntityName: financialEntityName,
          purchases: purchaseList,
          total: state.selectedCurrency.totalAmountPerFinancialEntity(
            purchases: purchaseList,
            currency: state.currency,
          ),
          currency: state.currency,
          selectedCurrency: state.selectedCurrency,
        );
        Navigator.of(context).pop();
      },
      content: const Text('¿Estas seguro que queres pagar el mes?'),
      title: 'Pagar mes',
      isEnabled: true,
    );
  }
}
