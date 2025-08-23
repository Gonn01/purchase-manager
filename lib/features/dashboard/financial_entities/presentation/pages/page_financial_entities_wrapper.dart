import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template PageFinancialEntitiesList}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
@RoutePage()
class PageFinancialEntitiesWrapper extends StatelessWidget {
  /// {@macro PageFinancialEntitiesList}
  const PageFinancialEntitiesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
