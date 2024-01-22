import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/financial_entitys/bloc/bloc_financial_entities.dart';

/// {@template ViewFinancialEntityDetails}
/// Pagina que contiene los detalles de una entidad financiera
///
/// Page that contains the details of a financial entity
/// {@endtemplate}
class ViewFinancialEntityDetails extends StatelessWidget {
  /// {@macro ViewFinancialEntityDetails}
  const ViewFinancialEntityDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocFinancialEntities, BlocFinancialEntitiesState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.financialEntitySelected?.logs.map(Text.new) ?? [],
            ...state.financialEntitySelected?.purchases.map(
                  (e) => Text(e.nameOfProduct),
                ) ??
                [],
          ],
        );
      },
    );
  }
}
