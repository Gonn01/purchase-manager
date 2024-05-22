import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
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
                        (e) => GestureDetector(
                          onTap: () => context.router.push(
                            RutaPurchaseDetails(
                              idPurchase: e.id,
                              idFinancialEntity:
                                  state.financialEntitySelected?.id ?? '',
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  '- ${e.nameOfProduct.capitalize}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: e.type.isCurrent
                                        ? null
                                        : TextDecoration.lineThrough,
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
                        ),
                      )
                      .toList() ??
                  [],
            ),
            ExpansionTile(
              title: const Text('Logs'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: state.financialEntitySelected?.logs
                      .map(
                        (e) => Text(
                          '- $e',
                          textAlign: TextAlign.start,
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ],
        );
      },
    );
  }
}
