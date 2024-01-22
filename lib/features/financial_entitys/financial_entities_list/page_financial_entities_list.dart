import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/features/financial_entitys/financial_entities_list/view/view_financial_entities_list.dart';

/// {@template PageFinancialEntitiesList}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
@RoutePage()
class PageFinancialEntitiesList extends StatelessWidget {
  /// {@macro PageFinancialEntitiesList}
  const PageFinancialEntitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewFinancialEntitiesList();
  }
}
