import 'package:auto_route/auto_route.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
