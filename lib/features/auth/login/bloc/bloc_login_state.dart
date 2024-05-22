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
    this.errorMessage,
  });

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  /// Mensaje de error en caso de que haya ocurrido un error.
  ///
  /// Error message in case an error has occurred.
  final String? errorMessage;

  @override
  List<dynamic> get props => [
        status,
        errorMessage,
      ];

  /// Copia el estado actual y lo modifica con los valores pasados por parametro
  ///
  /// Copy the current state and modify it with the values ​​passed by parameter
  BlocLoginState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return BlocLoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
