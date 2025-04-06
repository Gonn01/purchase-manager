part of 'bloc_dashboard.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocDashboardEvent {
  /// {@macro BlocInicioEvento}
  const BlocDashboardEvent();
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocDashboardEventInitialize extends BlocDashboardEvent {}

/// {@template BlocDashboardEventSelectCurrency}
/// Elimina una compra.
/// Deletes a purchase.
/// {@endtemplate}
class BlocDashboardEventSelectCurrency extends BlocDashboardEvent {
  ///{@macro BlocDashboardEventSelectCurrency}
  const BlocDashboardEventSelectCurrency({
    required this.selectedCurrency,
  });

  /// ID de la categoría a la que pertenece la compra.
  /// ID of the category to which the purchase belongs.
  final CurrencyType selectedCurrency;
}

/// {@template BlocDashboardEventSignOut}
/// Cierra sesión.
///
/// Sign out.
/// {@endtemplate}
class BlocDashboardEventSignOut extends BlocDashboardEvent {
  /// {@macro BlocDrawerEventSignOut}
  const BlocDashboardEventSignOut();
}
