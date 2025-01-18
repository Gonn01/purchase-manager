part of 'bloc_purchase_details.dart';

/// {@template BlocPurchaseDetailsState}
/// Maneja los distintos estados y variables guardadas en los mismos
///
/// Manage the different states and variables saved in them
/// {@endtemplate}
class BlocPurchaseDetailsState {
  /// {@macro BlocPurchaseDetailsState}
  const BlocPurchaseDetailsState._({
    this.purchase,
  });

  /// Estado previo.
  ///
  /// Previous state.
  BlocPurchaseDetailsState.from(
    BlocPurchaseDetailsState previousState, {
    Purchase? purchase,
  }) : this._(
          purchase: purchase ?? previousState.purchase,
        );

  /// Compra
  ///
  /// Purchase
  final Purchase? purchase;
}

/// {@template BlocPurchaseDetailsStateInitial}
/// Initial state of the home bloc.
/// {@endtemplate}
class BlocPurchaseDetailsStateInitial extends BlocPurchaseDetailsState {
  /// {@macro BlocPurchaseDetailsStateInitial}
  BlocPurchaseDetailsStateInitial() : super._();
}

/// {@template BlocPurchaseDetailsStateLoading}
/// State when the home is loading.
/// {@endtemplate}
class BlocPurchaseDetailsStateLoading extends BlocPurchaseDetailsState {
  /// {@macro BlocPurchaseDetailsStateLoading}
  BlocPurchaseDetailsStateLoading.from(super.previusState) : super.from();
}

/// {@template BlocPurchaseDetailsStateSuccess}
/// State when the home is loaded successfully.
/// {@endtemplate}
class BlocPurchaseDetailsStateSuccess extends BlocPurchaseDetailsState {
  /// {@macro BlocPurchaseDetailsStateSuccess}
  BlocPurchaseDetailsStateSuccess.from(super.previusState, {super.purchase})
      : super.from();
}

/// {@template BlocPurchaseDetailsStateError}
/// State when the home has an error.
/// {@endtemplate}
class BlocPurchaseDetailsStateError extends BlocPurchaseDetailsState {
  /// {@macro BlocPurchaseDetailsStateError}
  BlocPurchaseDetailsStateError.from(super.previusState) : super.from();
}
