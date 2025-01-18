part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocLoginState {
  /// {@macro BlocLoginEstado}
  const BlocLoginState._({
    this.errorMessage,
  });

  /// Estado previo.
  BlocLoginState.from(
    BlocLoginState? previusState, {
    String? errorMessage,
  }) : this._(
          errorMessage: errorMessage ?? previusState?.errorMessage,
        );

  /// Mensaje de error en caso de que haya ocurrido un error.
  ///
  /// Error message in case an error has occurred.
  final String? errorMessage;
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
  BlocLoginStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocLoginStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocLoginStateSuccess extends BlocLoginState {
  /// {@macro BlocLoginStateSuccess}
  BlocLoginStateSuccess.from(super.previusState) : super.from();
}

/// {@template BlocLoginStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocLoginStateError extends BlocLoginState {
  /// {@macro BlocLoginStateError}
  BlocLoginStateError.from(
    super.previusState, {
    super.errorMessage,
  }) : super.from();
}
