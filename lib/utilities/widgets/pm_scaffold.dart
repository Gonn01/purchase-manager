import 'package:flutter/material.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
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
    required this.type,
    required this.body,
    super.key,
  });

  /// Tipo de feature
  ///
  /// Type of feature
  final FeatureType type;

  /// Cuerpo del Scaffold
  ///
  /// Scaffold body
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        drawer: const PMDrawer(),
        appBar: PMAppbar(type: type),
        floatingActionButton: type != FeatureType.financialEntities &&
                type != FeatureType.financialEntitiesList &&
                type != FeatureType.financialEntityDetails &&
                type != FeatureType.purchaseDetails
            ? PMFloatingActionButton(type: type)
            : null,
        bottomNavigationBar: type != FeatureType.financialEntities &&
                type != FeatureType.financialEntitiesList &&
                type != FeatureType.financialEntityDetails &&
                type != FeatureType.purchaseDetails
            ? PMBottomNavigationBar(
                type: type,
              )
            : null,
        body: body,
      ),
    );
  }
}
