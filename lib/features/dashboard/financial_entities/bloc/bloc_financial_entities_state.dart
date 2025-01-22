part of 'bloc_financial_entities.dart';

/// {@template BlocFinancialEntitiesState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFinancialEntitiesState {
  /// {@macro BlocInicioEstado}
  const BlocFinancialEntitiesState._({
    this.financialEntitySelected,
    this.listFinancialEntity = const [],
  });

  /// Estado previo.
  ///
  /// Previous state.
  BlocFinancialEntitiesState.from(
    BlocFinancialEntitiesState previousState, {
    List<FinancialEntity>? listFinancialEntity,
    FinancialEntity? financialEntitySelected,
  }) : this._(
          listFinancialEntity:
              listFinancialEntity ?? previousState.listFinancialEntity,
          financialEntitySelected:
              financialEntitySelected ?? previousState.financialEntitySelected,
        );

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> listFinancialEntity;

  /// Entidad financiera seleccionada.
  ///
  /// Selected financial entity.
  final FinancialEntity? financialEntitySelected;
}

/// {@template BlocFinancialEntitiesStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocFinancialEntitiesStateInitial extends BlocFinancialEntitiesState {
  /// {@macro BlocFinancialEntitiesStateInitial}
  BlocFinancialEntitiesStateInitial() : super._();
}

/// {@template BlocFinancialEntitiesStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocFinancialEntitiesStateLoading extends BlocFinancialEntitiesState {
  /// {@macro BlocFinancialEntitiesStateLoading}
  BlocFinancialEntitiesStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocFinancialEntitiesStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntitiesStateSuccess extends BlocFinancialEntitiesState {
  /// {@macro BlocFinancialEntitiesStateSuccess}
  BlocFinancialEntitiesStateSuccess.from(
    super.previusState, {
    super.financialEntitySelected,
    super.listFinancialEntity,
  }) : super.from();
}

/// {@template BlocFinancialEntitiesStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocFinancialEntitiesStateError extends BlocFinancialEntitiesState {
  /// {@macro BlocFinancialEntitiesStateError}
  BlocFinancialEntitiesStateError.from(
    super.previusState, {
    required this.error,
  }) : super.from();

  /// Error message.
  final String error;
}
