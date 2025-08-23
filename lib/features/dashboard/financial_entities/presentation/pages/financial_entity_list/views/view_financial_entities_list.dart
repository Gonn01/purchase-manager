import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/data/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/presentation/bloc/bloc_financial_entity_details/bloc_financial_entity_details.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/presentation/bloc/bloc_financial_entity_list/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/presentation/pages/widgets/dialogs/dialog_delete_financial_entity.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_create_financial_entity.dart';

/// {@template ViewFinancialEntitiesList}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
class ViewFinancialEntitiesList extends StatelessWidget {
  /// {@macro ViewFinancialEntitiesList}
  const ViewFinancialEntitiesList({super.key});

  /// Muestra un dialog para eliminar una entidad financiera
  ///
  /// Show a dialog to delete a financial entity
  Future<void> _dialogDeleteFinancialEntity(
    BuildContext context,
    FinancialEntityListDto financialEntity,
  ) {
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocFinancialEntityDetails>(),
        child: DialogDeleteFinancialEntity(financialEntity: financialEntity),
      ),
    );
  }

  Future<void> _createFinancialEntity(BuildContext context) {
    return showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocFinancialEntityDetails>(),
        child: const DialogCreateFinancialEntity(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocDashboard, BlocDashboardState>(
      listener: (context, state) {
        if (state is BlocDashboardStateCreateFinancialEntityTriggered) {
          _createFinancialEntity(context);
        }
      },
      child:
          BlocConsumer<BlocFinancialEntityList, BlocFinancialEntityListState>(
        listener: (context, state) {
          if (state is BlocFinancialEntityListStateError) {
            showDialog<void>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.exception.title ?? 'An error occurred'),
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
        builder: (context, state) {
          if (state.financialEntityList.isEmpty) {
            return const Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'No hay entidades financieras',
                      style: TextStyle(
                        color: Color(0xff047269),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is BlocHomeStateLoading) {
            return const Column(
              children: [
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: state.financialEntityList
                    .map(
                      (financialEntity) => GestureDetector(
                        onTap: () => context.router.push(
                          RutaFinancialEntityDetails(
                            idFinancialEntity: financialEntity.id,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                financialEntity.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _dialogDeleteFinancialEntity(
                                  context,
                                  financialEntity,
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
