part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocLoginState extends Equatable {
  /// {@macro BlocLoginEstado}
  const BlocLoginState({
    this.status = Status.initial,
  });

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  @override
  List<Object> get props => [
        status,
      ];

  /// Copia el estado actual y lo modifica con los valores pasados por parametro
  ///
  /// Copy the current state and modify it with the values ​​passed by parameter
  BlocLoginState copyWith({
    Status? status,
  }) {
    return BlocLoginState(
      status: status ?? this.status,
    );
  }
}
