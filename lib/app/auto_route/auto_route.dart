import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/app/auto_route/router_guards.dart';

class MyObserver extends AutoRouterObserver {
  final _routeStreamController = StreamController<String>.broadcast();

  Stream<String> get routeStream => _routeStreamController.stream;

  @override
  void didPush(Route route, Route? previousRoute) {
    _routeStreamController.add(route.settings.name ?? '1');
    print('object');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _routeStreamController.add(route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _routeStreamController.add(route.name);
  }

  void dispose() {
    _routeStreamController.close();
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Ruta')

/// {@template AppRouter}
/// Se encarga de manejar las rutas de la aplicacion
/// {@endtemplate}
class AppRouter extends RootStackRouter {
  /// Se encarga de proteger las rutas que requieren
  /// que el usuario este deslogueado, en caso de que
  /// el usuario este logueado y quiera dirigirse a este tipo
  /// de paginas, sera redireccionado a [RutaLogin]
  InitialGuard get initialGuard => InitialGuard();

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
          guards: [initialGuard],
        ),
        AutoRoute(
          page: RutaDashboard.page,
          path: '/dashboard',
          guards: [authGuard],
          initial: true,
          children: [
            AutoRoute(
              page: RutaHome.page,
              initial: true,
              path: 'home',
              title: (context, data) => 'Inicio',
            ),
            AutoRoute(
              page: RutaFinancialEntities.page,
              path: 'financial-entities',
              guards: [authGuard],
              title: (context, data) => 'Entidades Financieras',
              children: [
                AutoRoute(
                  page: RutaFinancialEntitiesList.page,
                  initial: true,
                  path: 'list',
                  title: (context, data) => 'Lista de entidades financieras',
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
          ],
        ),
      ];
}
