import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:purchase_manager/features/dashboard/current_purchases/view/view_current_debtor.dart';
import 'package:purchase_manager/features/dashboard/current_purchases/view/view_current_creditor.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PageCurrentPurchase extends StatelessWidget {
  const PageCurrentPurchase({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        ViewDebt(),
        ViewDebtor(),
      ],
    );
  }
}
