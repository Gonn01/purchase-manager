import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/bloc/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/widgets/dialogs/dialog_delete_financial_entity.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';

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
    FinancialEntity financialEntity,
  ) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocFinancialEntityList>(),
        child: DialogDeleteFinancialEntity(financialEntity: financialEntity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocFinancialEntityList, BlocFinancialEntityListState>(
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
        if (state is BlocDashboardStateLoading) {
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
    );
  }
}
