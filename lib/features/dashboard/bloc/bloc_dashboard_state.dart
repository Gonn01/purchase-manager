part of 'bloc_dashboard.dart';

/// {@template BlocDashboardState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocDashboardState {
  /// {@macro BlocInicioEstado}
  const BlocDashboardState._({
    this.currency = const Currency.empty(),
    this.selectedCurrency = CurrencyType.pesoArgentino,
  });

  /// Estado previo.
  BlocDashboardState.from(
    BlocDashboardState previousState, {
    Currency? currency,
    CurrencyType? selectedCurrency,
  }) : this._(
          currency: currency ?? previousState.currency,
          selectedCurrency: selectedCurrency ?? previousState.selectedCurrency,
        );

  ///
  final CurrencyType selectedCurrency;

  /// Moneda actual.
  ///
  /// Current currency.
  final Currency currency;

  double totalAmountPerMonth(List<FinancialEntity> list) =>
      selectedCurrency.totalAmountPerMonth(
        financialEntities: list,
        currency: currency,
      );
}

/// {@template BlocDashboardStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocDashboardStateInitial extends BlocDashboardState {
  /// {@macro BlocDashboardStateInitial}
  BlocDashboardStateInitial() : super._();
}

/// {@template BlocDashboardStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocDashboardStateLoading extends BlocDashboardState {
  /// {@macro BlocDashboardStateLoading}
  BlocDashboardStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocDashboardStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDashboardStateSuccess extends BlocDashboardState {
  /// {@macro BlocDashboardStateSuccess}
  BlocDashboardStateSuccess.from(
    super.previusState, {
    super.currency,
    super.selectedCurrency,
  }) : super.from();
}

/// {@template BlocDashboardStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocDashboardStateError extends BlocDashboardState {
  /// {@macro BlocDashboardStateError}
  BlocDashboardStateError.from(
    super.previusState,
    this.error,
  ) : super.from();

  /// Error message.
  final String? error;
}

/// {@template BlocDashboardStateSuccessSignOut}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDashboardStateSuccessSignOut extends BlocDashboardState {
  /// {@macro BlocDashboardStateSuccessSignOut}
  BlocDashboardStateSuccessSignOut.from(super.previusState) : super.from();
}
