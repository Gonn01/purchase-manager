import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/bloc/bloc_financial_entity_list.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/utilities/widgets/pm_scaffold.dart';

@RoutePage()

/// {@template PageDashboard}
/// Pagina que contiene el dashboard de la aplicacion
///
/// Page that contains the application dashboard
/// {@endtemplate}
class PageDashboard extends StatelessWidget {
  /// {@macro PageFinancialEntities}
  const PageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BlocDashboard()..add(BlocDashboardEventInitialize()),
        ),
        BlocProvider(
          create: (context) => BlocHome()..add(BlocHomeEventInitialize()),
        ),
        BlocProvider(
          create: (context) => BlocFinancialEntityList()
            ..add(BlocFinancialEntityListEventInitialize()),
        ),
      ],
      child: AutoRouter(
        builder: (context, content) {
          return PMScaffold(
            body: switch (context.router.current.name) {
              RutaHome.name => content,
              RutaFinancialEntitiesList.name => content,
              _ => const SizedBox.shrink()
            },
          );
        },
      ),
    );
  }
}
