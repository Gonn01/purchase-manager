import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/dialogs/dialog_create_purchase.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

/// {@template PMFloatingActionButton}
/// Boton flotante de la aplicacion que permite crear una compra
///
/// Application floating button that allows you to create a purchase
/// {@endtemplate}
class PMFloatingActionButton extends StatelessWidget {
  /// {@macro PMFloatingActionButton}
  const PMFloatingActionButton({
    required this.type,
    super.key,
  });

  /// Muestra el dialog para crear una compra
  ///
  /// Show the dialog to create a purchase
  Future<void> _createPurchase({
    required BuildContext context,
    required bool current,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: DialogCreatePurchase(current: current),
      ),
    );
  }

  /// Tipo de feature
  final FeatureType type;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff02B3A3),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () => _createPurchase(
        context: context,
        current: !type.isSettled,
      ),
    );
  }
}
