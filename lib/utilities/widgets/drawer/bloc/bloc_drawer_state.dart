part of 'bloc_drawer.dart';

/// {@template BlocDrawerState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocDrawerState extends Equatable {
  /// {@macro BlocDrawerState}
  const BlocDrawerState({
    this.status = Status.initial,
  });

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  @override
  List<dynamic> get props => [
        status,
      ];

  /// Copia el estado actual y lo modifica con los parámetros proporcionados.
  /// Copy the current state and modify it with the provided parameters.
  BlocDrawerState copyWith({
    Status? estado,
    Purchase? purchase,
  }) {
    return BlocDrawerState(
      status: estado ?? status,
    );
  }
}
