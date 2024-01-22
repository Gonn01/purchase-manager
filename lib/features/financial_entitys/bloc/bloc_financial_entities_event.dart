part of 'bloc_financial_entities.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocFinancialEntitiesEvento extends Equatable {
  /// {@macro BlocInicioEvento}
  const BlocFinancialEntitiesEvento();

  @override
  List<Object> get props => [];
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocFinancialEntitiesEventInitialize
    extends BlocFinancialEntitiesEvento {}

/// {@template BlocFinancialEntitiesEventCreateFinancialEntity}
/// Crea una nueva categoría.
/// Creates a new category.
/// {@endtemplate}
class BlocFinancialEntitiesEventCreateFinancialEntity
    extends BlocFinancialEntitiesEvento {
  ///{@macro BlocFinancialEntitiesEventCreateFinancialEntity}
  const BlocFinancialEntitiesEventCreateFinancialEntity({
    required this.financialEntityName,
  });

  /// Nombre de la categoría a crear.
  ///
  /// Name of the category to create.
  final String financialEntityName;
}

/// {@template BlocFinancialEntitiesEventDeleteFinancialEntity}
/// Elimina una categoría.
/// Deletes a category.
/// {@endtemplate}
class BlocFinancialEntitiesEventDeleteFinancialEntity
    extends BlocFinancialEntitiesEvento {
  ///{@macro BlocFinancialEntitiesEventDeleteFinancialEntity}
  const BlocFinancialEntitiesEventDeleteFinancialEntity({
    required this.idFinancialEntity,
  });

  /// ID de la [FinancialEntity] a eliminar.
  ///
  /// ID of the [FinancialEntity] to delete.
  final String idFinancialEntity;
}

/// {@template BlocFinancialEntitiesEventSelectFinancialEntity}
/// Selecciona una [FinancialEntity]
///
/// Select a [FinancialEntity]
/// {@endtemplate}
class BlocFinancialEntitiesEventSelectFinancialEntity
    extends BlocFinancialEntitiesEvento {
  ///{@macro BlocFinancialEntitiesEventSelectFinancialEntity}
  const BlocFinancialEntitiesEventSelectFinancialEntity({
    required this.financialEntity,
  });

  /// [FinancialEntity] seleccionada
  ///
  /// Selected [FinancialEntity]
  final FinancialEntity financialEntity;
}
