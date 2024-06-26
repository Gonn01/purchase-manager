import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:purchase_manager/utilities/widgets/pm_scaffold.dart';

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
    return BlocProvider(
      create: (context) => BlocHome(),
      child: AutoRouter(
        builder: (context, content) {
          return PMScaffold(
            type: FeatureType.values.firstWhere(
              (featureType) =>
                  featureType.featureName == context.router.current.name,
            ),
            body: switch (context.router.current.name) {
              RutaCurrentPurchases.name => content,
              RutaSettledPurchases.name => content,
              _ => const SizedBox.shrink()
            },
          );
        },
      ),
    );
  }
}
