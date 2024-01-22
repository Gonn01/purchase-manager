import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/financial_entitys/bloc/bloc_financial_entities.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/widgets/pm_scaffold.dart';

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
          return PMScaffold(
            type: FeatureType.values.firstWhere(
              (featureType) =>
                  featureType.featureName == context.router.current.name,
            ),
            body: switch (context.router.current.name) {
              RutaFinancialEntities.name => content,
              RutaFinancialEntitiesList.name => content,
              RutaFinancialEntityDetails.name => content,
              _ => const SizedBox.shrink()
            },
          );
        },
      ),
    );
  }
}
