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
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Nombre de la compra: ${state.purchase?.name ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (state.purchase?.image != null)
                Image.network(
                  state.purchase?.image ?? '',
                  height: 200,
                  width: 200,
                )
              else
                const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: Color(0xff02B4A3),
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.purchase?.logs
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '- $e',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}
