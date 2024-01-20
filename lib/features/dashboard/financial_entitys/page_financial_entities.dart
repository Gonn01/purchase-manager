import 'package:auto_route/auto_route.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/dialogs/dialog_delete_financial_entity.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PageFinancialEntities extends StatelessWidget {
  const PageFinancialEntities({super.key});

  Future<void> _dialogDeleteFinancialEntity(
      BuildContext context, FinancialEntity e) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: DialogDeleteFinancialEntity(financialEntity: e),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<BlocDashboard, BlocDashboardState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: state.financialEntityList
                  .map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.name),
                          GestureDetector(
                            onTap: () =>
                                _dialogDeleteFinancialEntity(context, e),
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
