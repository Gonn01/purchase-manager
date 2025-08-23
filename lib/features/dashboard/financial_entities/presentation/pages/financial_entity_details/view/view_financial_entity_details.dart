import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/presentation/bloc/bloc_financial_entity_details/bloc_financial_entity_details.dart';
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
    return BlocConsumer<BlocFinancialEntityDetails,
        BlocFinancialEntityDetailsState>(
      listener: (context, state) {
        if (state is BlocFinancialEntityDetailsStateError) {
          showDialog<void>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.exception.title ?? 'Error desconocido'),
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
        return ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'Nombre: ${state.financialEntityDetails?.name ?? ''}',
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
              children: state.financialEntityDetails?.purchases
                      .map(
                        (purchase) => GestureDetector(
                          onTap: () => context.router.push(
                            RutaPurchaseDetails(
                              idPurchase: purchase.id,
                              idFinancialEntity:
                                  state.financialEntityDetails?.id ?? 0,
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
                      .toList() ??
                  [],
            ),
            ExpansionTile(
              title: const Text('Logs'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: state.financialEntityDetails?.logs
                      .map(
                        (e) => Text(
                          '- ${e.content}',
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
              children: state.financialEntityDetails?.logs
                      .map(
                        (e) => Text(
                          '- ${e.content} - ${e.content} '
                          '(${e.createdAt.formatWithHour})',
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
