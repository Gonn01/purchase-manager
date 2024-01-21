import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';

/// {@template DialogDeletePurchase}
/// Dialogo para eliminar una compra
///
/// Dialog to delete a purchase
/// {@endtemplate}
class DialogDeletePurchase extends StatelessWidget {
  /// {@macro DialogDeletePurchase}
  const DialogDeletePurchase({
    required this.idPurchase,
    required this.idFinancialEntity,
    super.key,
  });

  /// Id de la compra a eliminar
  ///
  /// Id of the purchase to delete
  final String idPurchase;

  /// Id de la entidad financiera a la que pertenece la compra
  ///
  /// Id of the financial entity to which the purchase belongs
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
          '¿Estas seguro de eliminar esta compra? Se eliminara toda su '
          'informacion'),
      title: 'Eliminar Compra',
      isEnabled: true,
    );
  }
}
