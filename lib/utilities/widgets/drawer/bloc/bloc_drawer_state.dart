part of 'bloc_drawer.dart';

/// {@template BlocDrawerState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocDrawerState {
  /// {@macro BlocDrawerState}
  const BlocDrawerState({
    this.nada = false,
  });

  /// Estado de la página.
  ///
  /// Page status.
  final bool nada;
}

/// {@template BlocDrawerStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}

class BlocDrawerStateInitial extends BlocDrawerState {
  /// {@macro BlocDrawerStateInitial}
  BlocDrawerStateInitial() : super(nada: false);
}

/// {@template BlocDrawerStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocDrawerStateLoading extends BlocDrawerState {
  /// {@macro BlocDrawerStateLoading}
  BlocDrawerStateLoading.from(BlocDrawerState previousState)
      : super(nada: previousState.nada);
}

/// {@template BlocDrawerStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocDrawerStateSuccess extends BlocDrawerState {
  /// {@macro BlocDrawerStateSuccess}
  BlocDrawerStateSuccess.from(BlocDrawerState previousState)
      : super(nada: previousState.nada);
}

/// {@template BlocDrawerStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocDrawerStateError extends BlocDrawerState {
  /// {@macro BlocDrawerStateError}
  BlocDrawerStateError.from(BlocDrawerState previousState)
      : super(nada: previousState.nada);
}
