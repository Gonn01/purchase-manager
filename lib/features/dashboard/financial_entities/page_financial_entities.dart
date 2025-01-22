import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/bloc/bloc_financial_entities.dart';

@RoutePage()

/// {@template PageFinancialEntities}
/// Pagina que contiene las entidades financieras
///
/// Page that contains financial entities
/// {@endtemplate}
class PageFinancialEntities extends StatelessWidget {
  /// {@macro PageFinancialEntities}
  const PageFinancialEntities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocFinancialEntities(),
      child: AutoRouter(
        builder: (context, content) {
          return switch (context.router.current.name) {
            RutaFinancialEntitiesList.name => content,
            RutaFinancialEntityDetails.name => content,
            RutaPurchaseDetails.name => content,
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
