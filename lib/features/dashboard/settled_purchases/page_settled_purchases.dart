import 'package:auto_route/annotations.dart';
import 'package:purchase_manager/features/dashboard/settled_purchases/view/view_debtor_settled_purchases.dart';
import 'package:purchase_manager/features/dashboard/settled_purchases/view/view_creditor_settled_purchases.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PageSettledPurchases extends StatelessWidget {
  const PageSettledPurchases({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        ViewDebtorSettledPurchases(),
        ViewCreditorSettledPurchases(),
      ],
    );
  }
}