part of 'bloc_login.dart';

/// {@template BlocLoginEvento}
/// Define los eventos que pueden ocurrir en la página de Login.
///
/// Define the events that can occur on the Login page.
/// {@endtemplate}
abstract class BlocLoginEvent extends Equatable {
  /// {@macro BlocLoginEvento}
  const BlocLoginEvent();

  @override
  List<Object> get props => [];
}

/// {@template BlocLoginEventoInicializar}
/// Evento que se dispara al iniciar sesión.
///
/// Event that is triggered when logging in.
/// {@endtemplate}
class BlocLoginEventLogin extends BlocLoginEvent {}
