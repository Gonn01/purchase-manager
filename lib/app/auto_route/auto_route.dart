import 'package:auto_route/auto_route.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/app/auto_route/router_guards.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Ruta')

/// {@template AppRouter}
/// Se encarga de manejar las rutas de la aplicacion
/// {@endtemplate}
class AppRouter extends $AppRouter {
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
          page: RutaHome.page,
          path: '/home',
          guards: [authGuard],
          initial: true,
          children: [
            AutoRoute(
              page: RutaCurrentPurchases.page,
              initial: true,
              path: 'current-purchases',
            ),
            AutoRoute(
              page: RutaSettledPurchases.page,
              path: 'settled-purchases',
            ),
          ],
        ),
        AutoRoute(
          page: RutaFinancialEntities.page,
          path: '/financial-entities',
          guards: [authGuard],
          children: [
            AutoRoute(
              page: RutaFinancialEntitiesList.page,
              initial: true,
              path: 'list',
            ),
            AutoRoute(
              page: RutaFinancialEntityDetails.page,
              path: 'details',
            ),
          ],
        ),
        AutoRoute(
          page: RutaPurchaseDetails.page,
          path: '/purchase-details',
          guards: [authGuard],
        ),
      ];
}
