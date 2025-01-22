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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ruta = context.router.current.name;

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
                    color: ruta == 'RutaDashboard'
                        ? const Color(0xff00B3A3)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.home,
                      color:
                          ruta == 'RutaDashboard' ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                if (ruta == 'RutaDashboard')
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
                    color: ruta == 'RutaDashboard'
                        ? const Color(0xff00B3A3)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.groups_2_outlined,
                      color:
                          ruta == 'RutaDashboard' ? Colors.grey : Colors.white,
                    ),
                  ),
                ),
                if (ruta != 'RutaDashboard')
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
