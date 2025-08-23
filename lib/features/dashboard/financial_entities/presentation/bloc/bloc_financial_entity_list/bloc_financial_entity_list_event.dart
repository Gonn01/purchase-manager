part of 'bloc_financial_entity_list.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocFinancialEntityListEvent {
  /// {@macro BlocInicioEvento}
  const BlocFinancialEntityListEvent();
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocFinancialEntityListEventInitialize
    extends BlocFinancialEntityListEvent {}

/// {@template BlocFinancialEntityListEventDeleteFinancialEntity}
/// Elimina una categoría.
/// Deletes a category.
/// {@endtemplate}
class BlocFinancialEntityListEventDeleteFinancialEntity
    extends BlocFinancialEntityListEvent {
  ///{@macro BlocFinancialEntityListEventDeleteFinancialEntity}
  const BlocFinancialEntityListEventDeleteFinancialEntity({
    required this.idFinancialEntity,
  });

  /// ID de la categoría a eliminar.
  final int idFinancialEntity;
}
