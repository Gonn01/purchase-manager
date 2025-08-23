part of 'bloc_purchase_details.dart';

/// {@template BlocPurchaseDetailsEvent}
/// Define los eventos que pueden ocurrir en la página de inicio.
/// Defines the events that can occur on the home page.
/// {@endtemplate}
abstract class BlocPurchaseDetailsEvent {
  /// {@macro BlocPurchaseDetailsEvent}
  const BlocPurchaseDetailsEvent();
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
    required this.idFinancialEntity,
  });

  /// Id de la compra
  ///
  /// Purchase id
  final int idPurchase;

  /// Id de la entidad financiera
  ///
  /// Financial entity id
  final int idFinancialEntity;
}
