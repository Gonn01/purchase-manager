part of 'bloc_purchase_details.dart';

/// {@template BlocPurchaseDetailsState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocPurchaseDetailsState extends Equatable {
  /// {@macro BlocPurchaseDetailsState}
  const BlocPurchaseDetailsState({
    this.status = Status.initial,
    this.purchase,
  });

  /// Estado de la página.
  ///
  /// Page status.
  final Status status;

  final Purchase? purchase;

  @override
  List<dynamic> get props => [
        status,
        purchase,
      ];

  /// Copia el estado actual y lo modifica con los parámetros proporcionados.
  /// Copy the current state and modify it with the provided parameters.
  BlocPurchaseDetailsState copyWith({
    Status? estado,
    Purchase? purchase,
  }) {
    return BlocPurchaseDetailsState(
      status: estado ?? status,
      purchase: purchase ?? this.purchase,
    );
  }
}
