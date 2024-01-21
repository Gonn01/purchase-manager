import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/widgets/pm_scaffold.dart';

@RoutePage()

/// {@template PageDashboard}
/// Pagina que contiene el dashboard
///
/// Page that contains the dashboard
/// {@endtemplate}
class PageDashboard extends StatelessWidget {
  /// {@macro PageDashboard}
  const PageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocDashboard(),
      child: AutoRouter(
        builder: (context, content) {
          return PMScaffold(
            type: FeatureType.values.firstWhere(
              (featureType) =>
                  featureType.featureName == context.router.current.name,
            ),
            body: switch (context.router.current.name) {
              RutaDashboard.name => content,
              RutaCurrentPurchases.name => content,
              RutaSettledPurchases.name => content,
              RutaFinancialEntities.name => content,
              _ => const SizedBox.shrink()
            },
          );
        },
      ),
    );
  }
}
