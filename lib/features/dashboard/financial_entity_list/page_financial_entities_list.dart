import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/bloc/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/views/view_financial_entities_list.dart';

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
    return BlocProvider(
      create: (context) => BlocFinancialEntityList()
        ..add(BlocFinancialEntityListEventInitialize()),
      child: const ViewFinancialEntitiesList(),
    );
  }
}
