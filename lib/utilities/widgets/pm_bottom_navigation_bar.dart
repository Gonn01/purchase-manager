import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final rutaa = Provider.of<RouteData<dynamic>?>(context);
    return BottomAppBar(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  if (rutaa?.path != 'home') {
                    context.router.popAndPush(const RutaHome());
                  }
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: rutaa?.path == 'home'
                            ? const Color(0xff00B3A3)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.home,
                          color: rutaa?.path == 'home'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                    if (rutaa?.path == 'home')
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
                onTap: () {
                  if (rutaa?.path == 'home') {
                    context.router
                        .popAndPush(const RutaFinancialEntitiesList());
                  }
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: rutaa?.path == 'home'
                            ? Colors.transparent
                            : const Color(0xff00B3A3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.groups_2_outlined,
                          color: rutaa?.path == 'home'
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                    ),
                    if (rutaa?.path != 'home')
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
        ],
      ),
    );
  }
}
