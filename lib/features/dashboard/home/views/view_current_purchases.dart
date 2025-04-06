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
    context.read<BlocDashboard>().add(BlocDashboardEventInitialize());
    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  Widget build(BuildContext context) {
    final st = context.read<BlocDashboard>().state;
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        if (state is BlocDashboardStateLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }

        final totalEsteMes =
            st.totalAmountPerMonth(state.listFinancialEntitiesStatusCurrent);

        final total = st.selectedCurrency.totalAmount(
          financialEntityList: state.listFinancialEntitiesStatusCurrent,
          currency: st.currency,
        );

        final caducanEsteMesa = caducanEsteMes(
          financialEntities: state.financialEntityList,
        );

        final caducanEsteMesCount = caducanEsteMesDinero(
          financialEntities: state.financialEntityList,
          currency: st.currency,
          selectedCurrency: st.selectedCurrency,
        );

        final caducanEsteMesDinero2 = caducanEsteMesCount.isNegative
            ? caducanEsteMesCount * -1
            : caducanEsteMesCount;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'En total ${total.isNegative ? 'debo' : 'me deben'}: '
                '${(total.isNegative ? total * -1 : total).formatAmount} ${st.selectedCurrency.abreviation}',
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
                'Este mes ${totalEsteMes.isNegative ? 'debo' : 'me deben'}: '
                '${(totalEsteMes.isNegative ? totalEsteMes * -1 : totalEsteMes).formatAmount} ${st.selectedCurrency.abreviation}',
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
                'Este mes caducan $caducanEsteMesa '
                'compras\n(${caducanEsteMesDinero2.formatAmount} '
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
                children: state.listFinancialEntitiesStatusCurrent.isEmpty
                    ? [
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
                      ]
                    : state.listFinancialEntitiesStatusCurrent
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
