import 'package:auto_route/auto_route.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/models/feature_type.dart';
import 'package:purchase_manager/widgets/pm_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PageDashboard extends StatelessWidget {
  const PageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocDashboard(),
      child: AutoRouter(
        builder: (context, content) {
          return PMScaffold(
              type: FeatureType.values.firstWhere((featureType) =>
                  featureType.featureName == context.router.current.name),
              body: switch (context.router.current.name) {
                RutaCurrentPurchase.name => content,
                RutaHistory.name => content,
                RutaFinancialEntitys.name => content,
                _ => const SizedBox.shrink()
              });
        },
      ),
    );
  }
}
