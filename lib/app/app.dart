import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchase_manager/app/auto_route/auto_route.dart';
import 'package:purchase_manager/l10n/arb/app_localizations.dart';

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
        StreamProvider<RouteData<dynamic>?>(
          create: (_) => routeTitleManager.stream,
          initialData: null,
        ),
      ],
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
    );
  }
}
