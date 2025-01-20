import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/functions/total_amount.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_month.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// {@template ViewDebtorCurrentPurchases}
/// Vista de las compras vigentes deudoras
/// View of current debtor purchases
/// {@endtemplate}
class ViewCurrentPurchases extends StatefulWidget {
  /// {@macro ViewDebtorCurrentPurchases}
  const ViewCurrentPurchases({super.key});

  @override
  State<ViewCurrentPurchases> createState() => _ViewCurrentPurchasesState();
}

class _ViewCurrentPurchasesState extends State<ViewCurrentPurchases> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  Future<void> _refresh() async {
    _controller.add(SwipeRefreshState.loading);
    context.read<BlocHome>().add(BlocHomeEventInitialize());

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        if (state is BlocHomeStateLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Total adeudado: ${totalAmount(
                  financialEntityList: state.listFinancialEntitiesStatusCurrent,
                  dollarValue: state.currency?.venta ?? 0,
                ).formatAmount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff047269),
                ),
              ),
            ),
            const Divider(
              height: .5,
              thickness: 3,
              color: Color(0xff02B3A3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Total adeudado por mes: ${totalAmountPerMonth(
                  state: state,
                  financialEntities: state.listFinancialEntitiesStatusCurrent,
                  dollarValue: state.currency?.venta ?? 0,
                ).formatAmount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff047269),
                ),
              ),
            ),
            const Divider(
              height: .5,
              thickness: 3,
              color: Color(0xff02B3A3),
            ),
            Expanded(
              child: SwipeRefresh.material(
                onRefresh: _refresh,
                stateStream: _stream,
                indicatorColor: const Color(0xff02B3A3),
                children: [
                  Column(
                    children: state.listFinancialEntitiesStatusCurrent
                        .map(
                          (financialEntity) =>
                              financialEntity.purchases.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: FinancialEntityElement(
                                        financialEntity: financialEntity,
                                        featureType: FeatureType.current,
                                      ),
                                    )
                                  : Container(),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        );
      },
    );
  }
}
