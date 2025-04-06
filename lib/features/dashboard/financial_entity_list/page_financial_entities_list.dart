import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/bloc/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/views/view_financial_entities_list.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';

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
    return BlocListener<BlocFinancialEntityList, BlocFinancialEntityListState>(
      listener: (context, state) {
        if (state
            is BlocFinancialEntityListStateSuccessDeletingFinancialEntity) {
          context.read<BlocHome>().add(
                BlocHomeEventDeleteFinancialEntity(
                  idFinancialEntity: state.financialEntityDeletedId,
                ),
              );
        }
        if (state is BlocFinancialEntityListStateError) {
          showDialog<void>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: const ViewFinancialEntitiesList(),
    );
  }
}
