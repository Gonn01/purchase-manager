import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/features/dashboard/current_purchases/view/view_creditor_current_purchases.dart';
import 'package:purchase_manager/features/dashboard/current_purchases/view/view_debtor_current_purchases.dart';

@RoutePage()

/// {@template PageCurrentPurchases}
/// Pagina que contiene las compras vigentes
/// Page that contains current purchases
/// {@endtemplate}
class PageCurrentPurchases extends StatelessWidget {
  /// {@macro PageCurrentPurchases}
  const PageCurrentPurchases({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        ViewDebtorCurrentPurchases(),
        ViewCreditorCurrentPurchases(),
      ],
    );
  }
}
