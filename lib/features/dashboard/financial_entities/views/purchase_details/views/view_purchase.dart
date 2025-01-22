import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/views/purchase_details/bloc/bloc_purchase_details.dart';

/// {@template ViewPurchaseDetails}
/// Vista que contiene los detalles de una compra
///
/// View that contains the details of a purchase
/// {@endtemplate}
class ViewPurchaseDetails extends StatelessWidget {
  /// {@macro ViewPurchaseDetails}
  const ViewPurchaseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPurchaseDetails, BlocPurchaseDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            Image.network(
              state.purchase?.image ?? '',
              height: 200,
              width: 200,
            ),
            Text(
              'Nombre: ${state.purchase?.nameOfProduct ?? ''}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: const Text('Logs'),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: state.purchase?.logs
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
