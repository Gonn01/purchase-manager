import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_create_financial_entity.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_settings.dart';

/// {@template PMAppbar}
/// Appbar de la aplicacion
///
/// Application appbar
/// {@endtemplate}
class PMAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro PMAppbar}
  const PMAppbar({
    required this.route,
    required this.title,
    super.key,
  });

  /// Ruta actual
  ///
  /// Current route
  final RouteData route;

  /// Titulo de la appbar
  ///
  /// Appbar title
  final String title;

  Future<void> _createFinancialEntity(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: const DialogCreateFinancialEntity(),
      ),
    );
  }

  Future<void> _settings(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: const DialogSettings(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff02B3A3),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () => _createFinancialEntity(context),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () => _settings(context),
            child: const Icon(
              Icons.settings_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
