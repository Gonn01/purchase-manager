import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';

/// {@template AuthGuard}
/// Guardia para verificar si el usuario esta autenticado
/// Guard to verify if the user is authenticated
/// {@endtemplate}
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return router.replace<void>(const RutaLogin());
    }

    return resolver.next();
  }
}

/// {@template InitialGuard}
/// Guardia para verificar si el usuario esta autenticado al inicio
/// Guard to verify if the user is authenticated at the beginning
/// {@endtemplate}
class InitialGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return router.push<void>(const RutaDashboard());
    }

    return resolver.next();
  }
}
