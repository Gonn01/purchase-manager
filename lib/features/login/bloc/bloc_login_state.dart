part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocLoginState extends Equatable {
  /// {@macro BlocLoginEstado}
  const BlocLoginState({
    this.status = Status.initial,
  });

  final Status status;

  @override
  List<Object> get props => [
        status,
      ];

  BlocLoginState copyWith({
    Status? status,
  }) {
    return BlocLoginState(
      status: status ?? this.status,
    );
  }
}
