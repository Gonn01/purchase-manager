import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/create_purchase_dialog.dart';

/// {@template PMFloatingActionButton}
/// Boton flotante de la aplicacion que permite crear una compra
///
/// Application floating button that allows you to create a purchase
/// {@endtemplate}
class PMFloatingActionButton extends StatefulWidget {
  /// {@macro PMFloatingActionButton}
  const PMFloatingActionButton({
    super.key,
  });

  @override
  State<PMFloatingActionButton> createState() => _PMFloatingActionButtonState();
}

class _PMFloatingActionButtonState extends State<PMFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff02B3A3),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<BlocDashboard>(),
              child: const CreatePurchaseModal(),
            );
          },
        );
      },
    );
  }
}
