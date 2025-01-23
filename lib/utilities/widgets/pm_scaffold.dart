import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/utilities/widgets/drawer/pm_drawer.dart';
import 'package:purchase_manager/utilities/widgets/pm_appbar.dart';
import 'package:purchase_manager/utilities/widgets/pm_bottom_navigation_bar.dart';
import 'package:purchase_manager/utilities/widgets/pm_floating_action_button.dart';

/// {@template PMScaffold}
/// Plantilla de Scaffold para la aplicacion
///
/// Scaffold template for the application
/// {@endtemplate}
class PMScaffold extends StatelessWidget {
  /// {@macro PMScaffold}
  const PMScaffold({
    required this.body,
    super.key,
  });

  /// Cuerpo del Scaffold
  ///
  /// Scaffold body
  final Widget body;
  @override
  Widget build(BuildContext context) {
    final rutaa = Provider.of<RouteData?>(context);
    final ruta = context.router.current.name;
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      drawer: const PMDrawer(),
      appBar: PMAppbar(
        route: context.router.current,
        title: rutaa?.title(context) ?? '',
      ),
      floatingActionButton:
          ruta == 'RutaHome' ? const PMFloatingActionButton() : null,
      bottomNavigationBar: SafeArea(
        child: PMBottomNavigationBar(
          route: context.router.current,
        ),
      ),
      body: body,
    );
  }
}
