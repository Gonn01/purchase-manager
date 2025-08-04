import 'package:auto_route/auto_route.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/utilities/widgets/drawer/pm_drawer.dart';
import 'package:purchase_manager/utilities/widgets/pm_appbar.dart';

/// {@template PMScaffold}
/// Plantilla de Scaffold para la aplicacion
///
/// Scaffold template for the application
/// {@endtemplate}
class PMScaffold extends StatelessWidget {
  /// {@macro PMScaffold}
  const PMScaffold({
    required this.body,
    this.floatingActionButton,
    super.key,
  });

  /// Cuerpo del Scaffold
  ///
  /// Scaffold body
  final Widget body;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    final rutaa = Provider.of<RouteData<dynamic>?>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      drawer: const PMDrawer(),
      appBar: PMAppbar(
        title: rutaa?.title(context) ?? '',
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: CircleNavBar(
        activeIndex: rutaa?.name == RutaHome.name ? 0 : 1,
        activeIcons: const [
          Icon(Icons.home, color: Color(0xff02B3A3)),
          Icon(Icons.person, color: Color(0xff02B3A3)),
        ],
        inactiveIcons: const [
          Icon(Icons.home, color: Color(0xff02B3A3)),
          Icon(Icons.person, color: Color(0xff02B3A3)),
        ],
        color: Colors.white,
        circleColor: Colors.white,
        height: 60,
        onTap: (index) {
          if (index == 1 && rutaa?.path != 'financialEntities') {
            context.router.push(const RutaFinancialEntitiesList());
          } else if (index == 0 && rutaa?.path != 'home') {
            context.router.push(const RutaHome());
          }
        },
        shadowColor: const Color(0xff02B3A3),
        circleShadowColor: const Color(0xff02B3A3),
        elevation: 10,
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff02B3A3),
            Colors.white,
            Color(0xff02B3A3),
          ],
        ),
        circleGradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff02B3A3), Colors.white],
        ),
      ),
      body: body,
    );
  }
}
