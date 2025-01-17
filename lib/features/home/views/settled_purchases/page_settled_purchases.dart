import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/features/home/views/settled_purchases/view/view_settled_purchases.dart';

@RoutePage()

/// {@template PageSettledPurchases}
/// Pagina que contiene las compras liquidadas
/// Page that contains settled purchases
/// {@endtemplate}
class PageSettledPurchases extends StatelessWidget {
  /// {@macro PageSettledPurchases}
  const PageSettledPurchases({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ViewCreditorSettledPurchases();
  }
}
