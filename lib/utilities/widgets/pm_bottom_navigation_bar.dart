import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';

/// {@template PMBottomNavigationBar}
/// Barra de navegacion inferior
///
/// Bottom navigation bar
/// {@endtemplate}
class PMBottomNavigationBar extends StatelessWidget {
  /// {@macro PMBottomNavigationBar}
  const PMBottomNavigationBar({
    required this.route,
    super.key,
  });

  /// Ruta actual
  ///
  /// Current route
  final RouteData route;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => context.router.replace(const RutaHome()),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: route.path == 'home'
                        ? const Color(0xff00B3A3)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.home,
                      color: route.path == 'home' ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                if (route.path == 'home')
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff006F66),
                    ),
                  ),
              ],
            ),
          ),
          InkWell(
            onTap: () => context.router.replace(const RutaFinancialEntities()),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: route.path == 'home'
                        ? Colors.transparent
                        : const Color(0xff00B3A3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.groups_2_outlined,
                      color: route.path == 'home' ? Colors.grey : Colors.white,
                    ),
                  ),
                ),
                if (route.path != 'home')
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff006F66),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
