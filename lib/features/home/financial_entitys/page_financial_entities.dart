import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/dialogs/dialog_delete_financial_entity.dart';
import 'package:purchase_manager/models/financial_entity.dart';

@RoutePage()

/// {@template PageFinancialEntities}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
class PageFinancialEntities extends StatelessWidget {
  /// {@macro PageFinancialEntities}
  const PageFinancialEntities({super.key});

  Future<void> _dialogDeleteFinancialEntity(
    BuildContext context,
    FinancialEntity e,
  ) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: DialogDeleteFinancialEntity(financialEntity: e),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BlocHome, BlocHomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: state.financialEntityList
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.name),
                        GestureDetector(
                          onTap: () => _dialogDeleteFinancialEntity(context, e),
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
