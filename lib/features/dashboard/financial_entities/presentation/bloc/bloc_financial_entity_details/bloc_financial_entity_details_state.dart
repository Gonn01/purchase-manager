part of 'bloc_financial_entity_details.dart';

/// {@template BlocFinancialEntityDetailsState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFinancialEntityDetailsState {
  /// {@macro BlocInicioEstado}
  const BlocFinancialEntityDetailsState._({
    this.financialEntityDetails,
  });

  /// Estado previo.
  BlocFinancialEntityDetailsState.from(
    BlocFinancialEntityDetailsState previousState, {
    FinancialEntityDetailsDto? financialEntityDetails,
  }) : this._(
          financialEntityDetails:
              financialEntityDetails ?? previousState.financialEntityDetails,
        );

  /// Detailsa de entidades financieras.
  ///
  /// Details of financial entities.
  final FinancialEntityDetailsDto? financialEntityDetails;
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

/// {@template BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateSuccess
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity}
  BlocFinancialEntityDetailsStateSuccess.from(
    super.previusState, {
    required super.financialEntityDetails,
  }) : super.from();
}

/// {@template BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity}
  BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity.from(
    super.previusState, {
    required super.financialEntityDetails,
    required this.financialEntityDeletedId,
  }) : super.from();
  final int financialEntityDeletedId;
}

/// {@template BlocFinancialEntityDetailsStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateError
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateError}
  BlocFinancialEntityDetailsStateError.from(
    super.previusState, {
    required this.exception,
  }) : super.from();

  /// Error message.
  final CustomException exception;
}

/// {@template BlocFinancialEntityDetailsStateSuccessDeletingFinancialEntity}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocFinancialEntityDetailsStateSuccessCreatingFinancialEntity
    extends BlocFinancialEntityDetailsState {
  /// {@macro BlocFinancialEntityDetailsStateSuccessCreatingFinancialEntity}
  BlocFinancialEntityDetailsStateSuccessCreatingFinancialEntity.from(
    super.previusState, {
    required super.financialEntityDetails,
  }) : super.from();
}
