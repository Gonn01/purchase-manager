import 'package:flutter/material.dart';
import 'package:purchase_manager/app/auto_route/auto_route.dart';
import 'package:purchase_manager/l10n/l10n.dart';

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

    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.config(),
    );
  }
}
