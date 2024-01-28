import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/purchase_details/bloc/bloc_purchase_details.dart';
import 'package:purchase_manager/features/purchase_details/view/view_purchase.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/widgets/pm_scaffold.dart';

/// {@template PagePurchaseDetails}
/// Pagina de detalles de una compra
///
/// Purchase details page
/// {@endtemplate}
@RoutePage()
class PagePurchaseDetails extends StatelessWidget {
  /// {@macro PagePurchaseDetails}
  const PagePurchaseDetails({
    @PathParam('idPurchase') required this.idPurchase,
    @PathParam('idFinancialEntity') required this.idFinancialEntity,
    super.key,
  });

  /// Id de la compra
  ///
  /// Purchase id
  final String idPurchase;

  /// Id de la entidad financiera
  ///
  /// Financial entity id
  final String idFinancialEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocPurchaseDetails()
        ..add(
          BlocPurchaseDetailsEventInitialize(
            idPurchase: idPurchase,
            idFinancialEntity: idFinancialEntity,
          ),
        ),
      child: const PMScaffold(
        type: FeatureType.purchaseDetails,
        body: ViewPurchaseDetails(),
      ),
    );
  }
}
