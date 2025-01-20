import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/financial_entity_element.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// {@template ViewCreditorSettledPurchases}
/// Vista de las compras liquidadas acreedoras
/// View of settled creditor purchases
/// {@endtemplate}
class ViewCreditorSettledPurchases extends StatefulWidget {
  /// {@macro ViewCreditorSettledPurchases}
  const ViewCreditorSettledPurchases({super.key});

  @override
  State<ViewCreditorSettledPurchases> createState() =>
      _ViewCreditorSettledPurchasesState();
}

class _ViewCreditorSettledPurchasesState
    extends State<ViewCreditorSettledPurchases> {
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
                          featureType: FeatureType.settled,
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
