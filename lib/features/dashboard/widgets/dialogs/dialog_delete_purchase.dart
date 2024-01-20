import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogDeletePurchase extends StatelessWidget {
  const DialogDeletePurchase({
    required this.idPurchase,
    required this.idFinancialEntity,
    super.key,
  });
  final String idPurchase;
  final String idFinancialEntity;

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      onTapConfirm: () {
        context.read<BlocDashboard>().add(
              BlocDashboardEventDeletePurchase(
                idPurchase: idPurchase,
                idFinancialEntity: idFinancialEntity,
              ),
            );

        Navigator.pop(context);
      },
      content: const Text(
          '¿Estas seguro de eliminar esta compra? Se eliminara toda su informacion'),
      title: 'Eliminar Compra',
      isEnabled: true,
    );
  }
}
