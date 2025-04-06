import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:purchase_manager/features/dashboard/purchase_details/bloc/bloc_purchase_details.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';

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
              CircularPercentIndicator(
                radius: 50,
                lineWidth: 10,
                percent: state.purchase?.numberOfQuotas != null
                    ? state.purchase!.payedQuotas /
                        state.purchase!.numberOfQuotas
                    : 0,
                header: Text(
                  state.purchase?.name ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff02B4A3),
                  ),
                ),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Text(
                      '${(state.purchase?.payedQuotas != null ? (state.purchase!.payedQuotas / state.purchase!.numberOfQuotas) : 0).toStringAsFixed(2)}%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.grey,
                progressColor: const Color(0xff02B4A3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.purchase?.logs
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10)
                                .copyWith(bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '- ${e.content}',
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Text(
                                      '- ${e.createdAt.toLocal().formatWithHour}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ],
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
