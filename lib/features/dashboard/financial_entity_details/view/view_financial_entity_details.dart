import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_details/bloc/bloc_financial_entity_details.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';

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
    return BlocBuilder<BlocFinancialEntityDetails,
        BlocFinancialEntityDetailsState>(
      builder: (context, state) {
        final purchases = state.financialEntity?.purchases ?? [];

        final ordenadas = purchases
          ..sort(
            (a, b) => a.createdAt.compareTo(b.createdAt),
          );

        final groupedByDate = groupBy(
          state.lastMovements,
          (e) => DateFormat('yyyy-MM-dd').format(e.createdAt),
        );

        return ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'Nombre: ${state.financialEntity?.name ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ExpansionTile(
              title: const Text('Compras'),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              children: ordenadas
                  .map(
                    (purchase) => GestureDetector(
                      onTap: () => context.router.push(
                        RutaPurchaseDetails(
                          idPurchase: purchase.id,
                          idFinancialEntity: state.financialEntity?.id ?? 0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '- ${purchase.name.capitalize}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: purchase.type.isCurrent
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
                            Text(
                              purchase.createdAt.formatWithHour,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            ExpansionTile(
              title: const Text('Logs'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: state.financialEntity?.logs
                      .map(
                        (e) => Text(
                          '- $e',
                          textAlign: TextAlign.start,
                        ),
                      )
                      .toList() ??
                  [],
            ),
            ExpansionTile(
              title: const Text('Últimos movimientos'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: groupedByDate.entries.expand((entry) {
                final date =
                    DateFormat('dd/MM/yyyy').format(DateTime.parse(entry.key));
                final logs = entry.value;

                return [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 4),
                    child: Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...logs.map(
                    (e) => Text(
                      '- ${e.purchaseName} - ${e.content} (${DateFormat.Hm().format(e.createdAt)})',
                      textAlign: TextAlign.start,
                    ),
                  ),
                ];
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
