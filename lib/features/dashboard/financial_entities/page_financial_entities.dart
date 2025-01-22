import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';

@RoutePage()

/// {@template PageFinancialEntities}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
class PageFinancialEntities extends StatelessWidget {
  /// {@macro PageFinancialEntities}
  const PageFinancialEntities({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (context, content) {
        return switch (context.router.current.name) {
          RutaFinancialEntitiesList.name => content,
          RutaFinancialEntityDetails.name => content,
          RutaPurchaseDetails.name => content,
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
