import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/functions/total_amount.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_month.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// {@template ViewDebtorCurrentPurchases}
/// Vista de las compras vigentes deudoras
/// View of current debtor purchases
/// {@endtemplate}
class ViewCurrentPurchases extends StatefulWidget {
  /// {@macro ViewDebtorCurrentPurchases}
  const ViewCurrentPurchases({
    required this.index,
    super.key,
  });

  /// Indice de la entidad financiera
  ///
  /// Index of the financial entity
  final int index;
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
        final totalEsteMes = totalAmountPerMonth(
          state: state,
          financialEntities: state.listFinancialEntitiesStatusCurrent,
          dollarValue: state.currency?.venta ?? 0,
        );

        final total = totalAmount(
          financialEntityList: state.listFinancialEntitiesStatusCurrent,
          dollarValue: state.currency?.venta ?? 0,
        );

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
                '''En total ${total.isNegative ? 'debo' : 'me deben'}: ${(total.isNegative ? total * -1 : total).formatAmount}''',
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
                '''Este mes ${totalEsteMes.isNegative ? 'debo' : 'me deben'}: ${(totalEsteMes.isNegative ? totalEsteMes * -1 : totalEsteMes).formatAmount}''',
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
                children: state.listFinancialEntitiesStatusCurrent
                    .map(
                      (financialEntity) => financialEntity.purchases.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: FinancialEntityElement(
                                financialEntity: financialEntity,
                                index: widget.index,
                              ),
                            )
                          : Container(),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
