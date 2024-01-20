part of 'bloc_login.dart';

/// {@template BlocLoginEvento}
/// Define los eventos que pueden ocurrir en la página de Login.
/// {@endtemplate}
abstract class BlocLoginEvent extends Equatable {
  /// {@macro BlocLoginEvento}
  const BlocLoginEvent();

  @override
  List<Object> get props => [];
}

/// {@template BlocLoginEventoInicializar}
/// Inicializa la página de Login.
/// {@endtemplate}
class BlocLoginEventInitialize extends BlocLoginEvent {}
