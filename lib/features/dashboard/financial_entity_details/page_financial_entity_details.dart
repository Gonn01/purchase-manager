import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_details/bloc/bloc_financial_entity_details.dart';
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
    required this.idFinancialEntity,
    super.key,
  });

  /// Identificador de la entidad financiera
  ///
  /// Identifier of the financial entity
  final int idFinancialEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocFinancialEntityDetails()
        ..add(
          BlocFinancialEntityDetailsEventInitialize(
            financialEntityId: idFinancialEntity,
          ),
        ),
      child: const ViewFinancialEntityDetails(),
    );
  }
}
