part of 'bloc_financial_entities.dart';

/// {@template BlocFinancialEntitiesState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocFinancialEntitiesState extends Equatable {
  /// {@macro BlocInicioEstado}
  const BlocFinancialEntitiesState({
    this.financialEntitySelected,
    this.listFinancialEntity = const [],
    this.status = Status.initial,
  });

  /// Lista de entidades financieras.
  ///
  /// List of financial entities.
  final List<FinancialEntity> listFinancialEntity;
  final FinancialEntity? financialEntitySelected;

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  @override
  List<dynamic> get props => [
        status,
        listFinancialEntity,
        financialEntitySelected,
      ];

  /// Copia el estado actual y lo modifica con los parámetros proporcionados.
  /// Copy the current state and modify it with the provided parameters.
  BlocFinancialEntitiesState copyWith({
    List<FinancialEntity>? listFinancialEntities,
    Status? estado,
    FinancialEntity? financialEntitySelected,
  }) {
    return BlocFinancialEntitiesState(
      listFinancialEntity: listFinancialEntities ?? listFinancialEntity,
      status: estado ?? status,
      financialEntitySelected:
          financialEntitySelected ?? this.financialEntitySelected,
    );
  }
}
