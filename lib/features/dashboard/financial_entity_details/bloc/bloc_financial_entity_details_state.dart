part of 'bloc_financial_entity_details.dart';

/// {@template BlocFinancialEntityDetailsState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFinancialEntityDetailsState {
  /// {@macro BlocInicioEstado}
  const BlocFinancialEntityDetailsState._({
    this.financialEntity,
    this.lastMovements = const [],
  });

  /// Estado previo.
  BlocFinancialEntityDetailsState.from(
    BlocFinancialEntityDetailsState previousState, {
    FinancialEntity? financialEntity,
    List<LastMovementLog>? lastMovements,
  }) : this._(
          financialEntity: financialEntity ?? previousState.financialEntity,
          lastMovements: lastMovements ?? previousState.lastMovements,
        );

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final FinancialEntity? financialEntity;
  final List<LastMovementLog> lastMovements;
}

/// {@template BlocFinancialEntityDetailsStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateInitial
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateInitial}
  BlocFinancialEntityDetailsStateInitial() : super._();
}

/// {@template BlocFinancialEntityDetailsStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateLoading
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateLoading}
  BlocFinancialEntityDetailsStateLoading.from(super.previusState)
      : super.from();
}

/// {@template BlocFinancialEntityDetailsStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateSuccess
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateSuccess}
  BlocFinancialEntityDetailsStateSuccess.from(
    super.previusState, {
    super.financialEntity,
    super.lastMovements,
  }) : super.from();
}

/// {@template BlocFinancialEntityDetailsStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateError
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateError}
  BlocFinancialEntityDetailsStateError.from(
    super.previusState,
    this.error,
  ) : super.from();

  /// Error message.
  final String? error;
}
