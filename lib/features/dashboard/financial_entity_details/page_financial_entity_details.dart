import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_details/view/view_financial_entity_details.dart';

/// {@template PageFinancialEntityDetails}
/// Pagina que contiene los detalles de una entidad financiera
///
/// Page that contains the details of a financial entity
/// {@endtemplate}
@RoutePage()
class PageFinancialEntityDetails extends StatelessWidget {
  /// {@macro PageFinancialEntityDetails}
  const PageFinancialEntityDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ViewFinancialEntityDetails();
  }
}
