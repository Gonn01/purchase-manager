import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/features/home/views/current_purchases/view/view_current_purchases.dart';

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
    return const ViewCurrentPurchases();
  }
}
