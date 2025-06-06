import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogDeletePurchase}
/// Dialog para eliminar una compra
///
/// Dialog to delete a purchase
/// {@endtemplate}
class DialogDeletePurchase extends StatelessWidget {
  /// {@macro DialogDeletePurchase}
  const DialogDeletePurchase({
    required this.purchase,
    required this.idFinancialEntity,
    super.key,
  });

  /// Compra a eliminar
  ///
  /// purchase to delete
  final Purchase purchase;

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
                purchase: purchase,
                idFinancialEntity: idFinancialEntity,
              ),
            );

        Navigator.pop(context);
      },
      content: const Text(
          '¿Estas seguro de eliminar esta compra? Se eliminara toda su '
          'informacion'),
      title: 'Eliminar Compra: ${purchase.nameOfProduct}',
      isEnabled: true,
    );
  }
}
