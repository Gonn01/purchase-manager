import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/dialogs/dialog_create_purchase.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

class PMFloatingActionButton extends StatelessWidget {
  const PMFloatingActionButton({
    required this.type,
    super.key,
  });

  Future<void> _createPurchase({
    required BuildContext context,
    required bool current,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: DialogCreatePurchase(current: current),
      ),
    );
  }

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
        current: type == FeatureType.current,
      ),
    );
  }
}
