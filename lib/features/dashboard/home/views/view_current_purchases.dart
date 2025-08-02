import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
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
    final st = context.read<BlocDashboard>().state;
    final selectedCurrency = st.selectedCurrency;
    final currency = st.currency;
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        if (state is BlocHomeStateLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }

        final total = selectedCurrency.totalAmount(
          financialEntityList: state.financialEntityList,
          currency: currency,
        );

        final totalEsteMes = state.totalAmountPerMonth(
            state.financialEntityList
                .where((e) => e.currentPurchases.isNotEmpty)
                .toList()
                .expand((e) => e.currentPurchases)
                .toList(),
            currency,
            selectedCurrency);

        final caducanEsteMes = calculateCaducanEsteMes(
          financialEntities: state.financialEntityList,
        );

        final caducanEsteMesCount = caducanEsteMesDinero(
          financialEntities: state.financialEntityList,
          currency: currency,
          selectedCurrency: selectedCurrency,
        );

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'En total ${total.deboOrMeDeben}: '
                '${total.abs().formatAmount} '
                '${st.selectedCurrency.abreviation}',
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
                'Este mes ${totalEsteMes.deboOrMeDeben}: '
                '${totalEsteMes.abs().formatAmount} '
                '${st.selectedCurrency.abreviation}',
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
                'Este mes caducan $caducanEsteMes '
                'compras\n(${caducanEsteMesCount.abs().formatAmount} '
                '${st.selectedCurrency.abreviation})',
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
                children: state.hasCurrentPurchases
                    ? state.financialEntitiesWithCurrentPurchases
                        .map(
                          (financialEntity) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: FinancialEntityElement(
                              financialEntity: financialEntity,
                              index: widget.index,
                            ),
                          ),
                        )
                        .toList()
                    : [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(
                            child: Text(
                              'No hay compras',
                              style: TextStyle(
                                color: Color(0xff047269),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        );
      },
    );
  }
}
