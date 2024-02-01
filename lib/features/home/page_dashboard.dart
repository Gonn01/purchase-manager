import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';
import 'package:purchase_manager/widgets/drawer/bloc/bloc_drawer.dart';
import 'package:purchase_manager/widgets/pm_scaffold.dart';

@RoutePage()

/// {@template PageHome}
/// Pagina que contiene el home
///
/// Page that contains the home
/// {@endtemplate}
class PageHome extends StatelessWidget {
  /// {@macro PageHome}
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlocHome(),
        ),
        BlocProvider(
          create: (context) => BlocDrawer(),
        ),
      ],
      child: AutoRouter(
        builder: (context, content) {
          return PMScaffold(
            type: FeatureType.values.firstWhere(
              (featureType) =>
                  featureType.featureName == context.router.current.name,
            ),
            body: switch (context.router.current.name) {
              RutaHome.name => content,
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
