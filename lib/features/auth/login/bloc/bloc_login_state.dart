part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocLoginState {
  /// {@macro BlocLoginEstado}
  const BlocLoginState._();

  /// Estado previo.
  BlocLoginState.from() : this._();
}

/// {@template BlocLoginStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocLoginStateInitial extends BlocLoginState {
  /// {@macro BlocLoginStateInitial}
  BlocLoginStateInitial() : super._();
}

/// {@template BlocLoginStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocLoginStateLoading extends BlocLoginState {
  /// {@macro BlocLoginStateLoading}
  BlocLoginStateLoading.from() : super.from();
}

/// {@template BlocLoginStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocLoginStateSuccess extends BlocLoginState {
  /// {@macro BlocLoginStateSuccess}
  BlocLoginStateSuccess.from() : super.from();
}

/// {@template BlocLoginStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocLoginStateError extends BlocLoginState {
  /// {@macro BlocLoginStateError}
  BlocLoginStateError.from({
    required this.exception,
  }) : super.from();
  final CustomException exception;
}
