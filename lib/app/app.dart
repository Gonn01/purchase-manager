import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/app/auto_route/auto_route.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/extensions/build_context.dart';

/// {@template App}
/// Aplicación principal
///
/// Main application
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro App}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiProvider(
      providers: [
        StreamProvider<List<ConnectivityResult>>(
          create: (_) => Connectivity().onConnectivityChanged,
          initialData: const [],
        ),
        StreamProvider<RouteData?>(
          create: (_) => routeTitleManager.stream,
          initialData: null,
        ),
      ],
      child: BlocProvider(
        create: (context) => BlocDashboard(),
        child: MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter.config(
            navigatorObservers: () => [MyObserver()],
          ),
        ),
      ),
    );
  }
}
