part of 'bloc_financial_entity_list.dart';

/// {@template BlocFinancialEntityListState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFinancialEntityListState {
  /// {@macro BlocInicioEstado}
  const BlocFinancialEntityListState._({
    this.financialEntityList = const [],
    this.lastMovements = const [],
  });

  /// Estado previo.
  BlocFinancialEntityListState.from(
    BlocFinancialEntityListState previousState, {
    List<FinancialEntity>? financialEntityList,
    List<LastMovementLog>? lastMovements,
  }) : this._(
          financialEntityList:
              financialEntityList ?? previousState.financialEntityList,
          lastMovements: lastMovements ?? previousState.lastMovements,
        );

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> financialEntityList;
  final List<LastMovementLog> lastMovements;
}

/// {@template BlocFinancialEntityListStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocFinancialEntityListStateInitial extends BlocFinancialEntityListState {
  /// {@macro BlocFinancialEntityListStateInitial}
  BlocFinancialEntityListStateInitial() : super._();
}

/// {@template BlocFinancialEntityListStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocFinancialEntityListStateLoading extends BlocFinancialEntityListState {
  /// {@macro BlocFinancialEntityListStateLoading}
  BlocFinancialEntityListStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocFinancialEntityListStateSuccessSignOut}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntityListStateSuccess extends BlocFinancialEntityListState {
  /// {@macro BlocFinancialEntityListStateSuccessSignOut}
  BlocFinancialEntityListStateSuccess.from(
    super.previusState, {
    super.financialEntityList,
  }) : super.from();
}

/// {@template BlocFinancialEntityListStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocFinancialEntityListStateError extends BlocFinancialEntityListState {
  /// {@macro BlocFinancialEntityListStateError}
  BlocFinancialEntityListStateError.from(
    super.previusState, {
    required this.error,
  }) : super.from();

  /// Error message.
  final String error;
}
