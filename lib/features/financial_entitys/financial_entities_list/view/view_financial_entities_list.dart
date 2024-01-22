import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/financial_entitys/bloc/bloc_financial_entities.dart';
import 'package:purchase_manager/features/financial_entitys/widgets/dialogs/dialog_delete_financial_entity.dart';
import 'package:purchase_manager/models/financial_entity.dart';

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
        value: context.read<BlocFinancialEntities>(),
        child: DialogDeleteFinancialEntity(financialEntity: financialEntity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BlocFinancialEntities, BlocFinancialEntitiesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: state.listFinancialEntity
                  .map(
                    (financialEntity) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<BlocFinancialEntities>().add(
                                  BlocFinancialEntitiesEventSelectFinancialEntity(
                                    financialEntity: financialEntity,
                                  ),
                                );
                            context.router.push(
                              const RutaFinancialEntityDetails(),
                            );
                          },
                          child: Text(financialEntity.name),
                        ),
                        GestureDetector(
                          onTap: () => _dialogDeleteFinancialEntity(
                            context,
                            financialEntity,
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
