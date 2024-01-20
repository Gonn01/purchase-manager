import 'package:flutter/material.dart';
import 'package:purchase_manager/models/feature_type.dart';
import 'package:purchase_manager/widgets/pm_appbar.dart';
import 'package:purchase_manager/widgets/pm_bottom_navigation_bar.dart';
import 'package:purchase_manager/widgets/pm_drawer.dart';
import 'package:purchase_manager/widgets/pm_floating_action_button.dart';

class PMScaffold extends StatelessWidget {
  const PMScaffold({
    required this.type,
    required this.body,
    super.key,
  });
  final FeatureType type;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        drawer: const PMDrawer(),
        appBar: PMAppbar(type: type),
        floatingActionButton: PMFloatingActionButton(type: type),
        bottomNavigationBar: type != FeatureType.categories
            ? PMBottomNavigationBar(
                type: type,
              )
            : null,
        body: body,
      ),
    );
  }
}
