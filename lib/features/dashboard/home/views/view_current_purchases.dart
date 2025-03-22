// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/functions/caducan_este_mes.dart';
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
    context.read<BlocDashboard>().add(BlocDashboardEventInitialize());

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        final totalEsteMes = state.selectedCurrency.totalAmountPerMonth(
          financialEntities: state.listFinancialEntitiesStatusCurrent,
          currency: state.currency,
        );

        final total = state.selectedCurrency.totalAmount(
          financialEntityList: state.listFinancialEntitiesStatusCurrent,
          currency: state.currency,
        );

        final caducanEsteMesa = caducanEsteMes(
          financialEntities: state.financialEntityList,
        );

        final caducanEsteMesCount = caducanEsteMesDinero(
          financialEntities: state.financialEntityList,
          currency: state.currency,
          selectedCurrency: state.selectedCurrency,
        );

        final caducanEsteMesDinero2 = caducanEsteMesCount.isNegative
            ? caducanEsteMesCount * -1
            : caducanEsteMesCount;

        if (state is BlocDashboardStateLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }

        if (state.listFinancialEntitiesStatusCurrent.isEmpty) {
          return const Center(
            child: Text(
              'No hay compras',
              style: TextStyle(
                color: Color(0xff047269),
                fontSize: 20,
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'En total ${total.isNegative ? 'debo' : 'me deben'}: ${(total.isNegative ? total * -1 : total).formatAmount} ${state.selectedCurrency.abreviation}',
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
                'Este mes ${totalEsteMes.isNegative ? 'debo' : 'me deben'}: ${(totalEsteMes.isNegative ? totalEsteMes * -1 : totalEsteMes).formatAmount} ${state.selectedCurrency.abreviation}',
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
                'Este mes caducan $caducanEsteMesa compras\n(${caducanEsteMesDinero2.formatAmount} ${state.selectedCurrency.abreviation})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff047269),
                ),
                textAlign: TextAlign.center,
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
