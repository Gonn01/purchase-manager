import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/bloc/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogDeleteFinancialEntity}
/// DialDialogogo para eliminar una entidad financiera
///
/// Dialog to delete a financial entity
/// {@endtemplate}
class DialogDeleteFinancialEntity extends StatelessWidget {
  /// {@macro DialogDeleteFinancialEntity}
  const DialogDeleteFinancialEntity({
    required this.financialEntity,
    super.key,
  });

  /// Entidad financiera a eliminar
  final FinancialEntityDto financialEntity;

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      onTapConfirm: () {
        context.read<BlocFinancialEntityList>().add(
              BlocFinancialEntityListEventDeleteFinancialEntity(
                idFinancialEntity: financialEntity.id,
              ),
            );

        Navigator.pop(context);
      },
      content: const Text(
          '¿Estas seguro de eliminar esta entidad financiera? Se eliminara '
          'toda su informacion'),
      title: 'Eliminar entidad financiera',
      isEnabled: true,
    );
  }
}
