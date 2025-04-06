import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/financial_entity_element.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// {@template ViewCreditorSettledPurchases}
/// Vista de las compras liquidadas acreedoras
/// View of settled creditor purchases
/// {@endtemplate}
class ViewSettledPurchases extends StatefulWidget {
  /// {@macro ViewCreditorSettledPurchases}
  const ViewSettledPurchases({
    required this.index,
    super.key,
  });

  /// Indice de la entidad financiera
  ///
  /// Index of the financial entity
  final int index;

  @override
  State<ViewSettledPurchases> createState() => _ViewSettledPurchasesState();
}

class _ViewSettledPurchasesState extends State<ViewSettledPurchases> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  Future<void> _refresh() async {
    _controller.add(SwipeRefreshState.loading);
    context.read<BlocDashboard>().add(BlocDashboardEventInitialize());

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        if (state is BlocDashboardStateLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff02B3A3),
            ),
          );
        }

        if (state.listFinancialEntityStatusSettled.isEmpty) {
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

        return SwipeRefresh.material(
          onRefresh: _refresh,
          stateStream: _stream,
          indicatorColor: const Color(0xff02B3A3),
          children: state.listFinancialEntityStatusSettled
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
        );
      },
    );
  }
}
