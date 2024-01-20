import 'package:auto_route/annotations.dart';
import 'package:purchase_manager/features/dashboard/history_purchases/view/view_history_debtor.dart';
import 'package:purchase_manager/features/dashboard/history_purchases/view/view_history_creditor.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PageHistory extends StatelessWidget {
  const PageHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        ViewHistoryDebt(),
        ViewHistoryDebtor(),
      ],
    );
  }
}
