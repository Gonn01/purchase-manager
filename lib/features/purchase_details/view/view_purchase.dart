import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/purchase_details/bloc/bloc_purchase_details.dart';

class ViewPurchaseDetails extends StatelessWidget {
  const ViewPurchaseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPurchaseDetails, BlocPurchaseDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
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
