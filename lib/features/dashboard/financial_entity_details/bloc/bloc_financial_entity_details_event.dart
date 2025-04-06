part of 'bloc_financial_entity_details.dart';

/// {@template BlocInicioEvento}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocFinancialEntityDetailsEvent {
  /// {@macro BlocInicioEvento}
  const BlocFinancialEntityDetailsEvent();
}

/// {@template BlocInicioEventoInicializar}
/// Inicializa la página de home.
/// Initialize the home page.
/// {@endtemplate}
class BlocFinancialEntityDetailsEventInitialize
    extends BlocFinancialEntityDetailsEvent {
  /// {@macro BlocInicioEventoInicializar}
  const BlocFinancialEntityDetailsEventInitialize({
    required this.financialEntityId,
  });
  final int financialEntityId;
}
