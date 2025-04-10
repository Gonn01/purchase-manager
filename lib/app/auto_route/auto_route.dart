// ignore_for_file: strict_raw_type asd

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/app/auto_route/router_guards.dart';

/// {@template RouteTitleManager}
/// Clase encargada de manejar los titulos de las rutas
///
/// Class in charge of managing the titles of the routes
/// {@endtemplate}
class RouteTitleManager {
  final _controller = StreamController<RouteData?>.broadcast();

  /// Expose the stream to listen to changes
  Stream<RouteData?> get stream => _controller.stream;

  /// Push a new title to the stream
  void updateTitle(RouteData? title) {
    _controller.add(title);
  }

  /// Close the controller when no longer needed
  void dispose() {
    _controller.close();
  }
}

/// Singleton instance
final routeTitleManager = RouteTitleManager();

/// {@template AutoRouterObserver}
/// Clase encargada de observar los cambios en las rutas
///
/// Class in charge of observing changes in routes
/// {@endtemplate}
class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    final title = route.data;
    routeTitleManager.updateTitle(title);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final title = newRoute?.data;
    routeTitleManager.updateTitle(title);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final title = route.data;
    routeTitleManager.updateTitle(title);
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Ruta')

/// {@template AppRouter}
/// Se encarga de manejar las rutas de la aplicacion
/// {@endtemplate}
class AppRouter extends RootStackRouter {
  /// Se encarga de proteger las rutas que requieren
  /// que el usuario este logeado, en caso de que
  /// el usuario este deslogueado y quiera dirigirse a este tipo
  /// de paginas, sera redireccionado a [RutaLogin]
  AuthGuard get authGuard => AuthGuard();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RutaLogin.page,
          path: '/login',
          guards: [authGuard],
          initial: true,
        ),
        AutoRoute(
          page: RutaDashboard.page,
          path: '/dashboard',
          children: [
            CustomRoute<AutoRoute>(
              page: RutaHome.page,
              initial: true,
              path: 'home',
              title: (context, data) => 'Inicio',
              transitionsBuilder: TransitionsBuilders.zoomIn,
            ),
            CustomRoute<AutoRoute>(
              page: RutaFinancialEntitiesList.page,
              path: 'list',
              title: (context, data) => 'Lista de entidades financieras',
              transitionsBuilder: TransitionsBuilders.zoomIn,
            ),
            AutoRoute(
              page: RutaFinancialEntityDetails.page,
              path: 'details',
              title: (context, data) => 'Detalles de la entidad financiera',
            ),
            AutoRoute(
              page: RutaPurchaseDetails.page,
              path: 'purchase',
              title: (context, data) => 'Detalles de la compra',
            ),
          ],
        ),
      ];
}
