part of 'bloc_purchase_details.dart';

/// {@template BlocPurchaseDetailsEvent}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocPurchaseDetailsEvent extends Equatable {
  /// {@macro BlocPurchaseDetailsEvent}
  const BlocPurchaseDetailsEvent();

  @override
  List<Object> get props => [];
}

/// {@template BlocFinancialEntitiesEventInitialize}
/// Inicializa la página de home.
///
/// Initialize the home page.
/// {@endtemplate}
class BlocPurchaseDetailsEventInitialize extends BlocPurchaseDetailsEvent {
  /// {@macro BlocPurchaseDetailsEventInitialize}
  const BlocPurchaseDetailsEventInitialize({
    required this.idPurchase,
  });

  /// Id de la compra
  ///
  /// Purchase id
  final String idPurchase;
}
