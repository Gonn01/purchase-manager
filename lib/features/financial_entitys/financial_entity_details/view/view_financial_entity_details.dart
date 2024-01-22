import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/extensions/string.dart';
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
        final fe = state.financialEntitySelected;
        return Column(
          children: [
            Text(
              'Nombre: ${fe?.name ?? ''}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: const Text('Compras'),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              children: state.financialEntitySelected?.purchases
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(
                                '- ${e.nameOfProduct.capitalize}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.launch,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            ExpansionTile(
              title: const Text('Logs'),
              children:
                  state.financialEntitySelected?.logs.map(Text.new).toList() ??
                      [],
            ),
          ],
        );
      },
    );
  }
}
