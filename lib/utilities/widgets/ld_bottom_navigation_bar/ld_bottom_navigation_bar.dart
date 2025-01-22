import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/utilities/widgets/ld_bottom_navigation_bar/widgets/bottom_navigation_bar_item.dart';

/// {@template LDBottomNavigationBar}
/// Bottom navigation bar for the app
/// {@endtemplate}

class LDBottomNavigationBar extends StatefulWidget {
  /// {@macro LDBottomNavigationBar}
  const LDBottomNavigationBar({
    super.key,
  });

  @override
  State<LDBottomNavigationBar> createState() => _LDBottomNavigationBarState();
}

class _LDBottomNavigationBarState extends State<LDBottomNavigationBar> {
  int index = 0;

  void _handleTap(
    int index,
  ) {
    setState(() => this.index = index);

    switch (index) {
      case 0:
        context.router.push(const RutaHome());

      case 1:
        context.router.push(const RutaFinancialEntities());
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionStates = Provider.of<List<ConnectivityResult>>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LDBottomNavigationBarItem(
              isSelected: context.router.current.name == RutaHome.name,
              value: 0,
              onTap: _handleTap,
              icon: Icons.home_outlined,
              text: 'Inicio',
            ),
            LDBottomNavigationBarItem(
              isSelected:
                  context.router.current.name == RutaFinancialEntities.name,
              value: 1,
              onTap: _handleTap,
              icon: Icons.list,
              text: 'Entidades Financieras',
            ),
          ],
        ),
        if (connectionStates.contains(ConnectivityResult.none))
          Container(
            height: 25,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: const Center(
              child: Text(
                'No internet connection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
