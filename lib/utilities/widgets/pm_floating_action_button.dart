import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';

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
    final ruta = Provider.of<RouteData<dynamic>?>(context);
    return FloatingActionButton(
      backgroundColor: const Color(0xff02B3A3),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () {
        if (ruta?.name == RutaHome.name) {
          print('Ruta Home FAB pressed');
          context.read<BlocDashboard>().add(
                const BlocDashboardEventCreatePurchaseTrigger(),
              );
        }
        if (ruta?.name == RutaFinancialEntitiesList.name) {
          print('Ruta Financial Entities List FAB pressed');
          context.read<BlocDashboard>().add(
                const BlocDashboardEventCreateFinancialEntityTrigger(),
              );
        }
      },
    );
  }
}
