import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template FeatureType}
/// Enumerador que contiene los tipos de features que se pueden mostrar
///
/// Enumerator that contains the types of features that can be displayed
/// {@endtemplate}
enum FeatureType {
  /// Tipo de feature home
  ///
  /// Home feature type
  home,

  /// Tipo de feature de compras vigentes deudoras
  ///
  /// Current debtor purchases feature type
  currentDebtor,

  /// Tipo de feature de compras vigentes acreedoras
  ///
  /// Current creditor purchases feature type
  currentCreditor,

  /// Tipo de feature de compras saldadas deudoras
  ///
  /// Settled debtor purchases feature type
  settledDebtor,

  /// Tipo de feature de compras saldadas acreedoras
  ///
  /// Settled creditor purchases feature type
  settledCreditor,

  /// Tipo de feature de entidades financieras
  ///
  /// Financial entities feature type
  financialEntities,

  /// Tipo de feature lista de [FinancialEntity]
  ///
  /// [FinancialEntity] list feature type
  financialEntitiesList,

  /// Tipo de feature detalles de [FinancialEntity]
  ///
  /// [FinancialEntity] details feature type
  financialEntityDetails,

  /// Tipo de feature detalles de [Purchase]
  ///
  /// [Purchase] details feature type
  purchaseDetails;

  /// Devuelve el nombre del tipo de feature
  ///
  /// Returns the name of the feature type
  String get name => switch (this) {
        FeatureType.currentDebtor || FeatureType.currentCreditor => 'Vigente',
        FeatureType.settledDebtor || FeatureType.settledCreditor => 'Historial',
        FeatureType.home => 'Home',
        FeatureType.financialEntities ||
        FeatureType.financialEntitiesList =>
          'Lista de entidades einancieras',
        FeatureType.financialEntityDetails => 'Entidades financiera',
        FeatureType.purchaseDetails => 'Detalles de la compra',
      };

  /// Devuelve el nombre de la feature segun el tipo de ruta
  ///
  /// Returns the name of the feature according to the route type
  String get featureName => switch (this) {
        FeatureType.currentDebtor ||
        FeatureType.currentCreditor =>
          RutaCurrentPurchases.name,
        FeatureType.settledDebtor ||
        FeatureType.settledCreditor =>
          RutaSettledPurchases.name,
        FeatureType.home => RutaHome.name,
        FeatureType.financialEntities => RutaFinancialEntities.name,
        FeatureType.financialEntitiesList => RutaFinancialEntitiesList.name,
        FeatureType.financialEntityDetails => RutaFinancialEntityDetails.name,
        FeatureType.purchaseDetails => RutaPurchaseDetails.name,
      };

  /// Devuelve un valor booleano segun el tipo de feature y la compra
  ///
  /// Returns a boolean value according to the feature type and the purchase
  bool getBooleanValue(FeatureType type, Purchase purchase) {
    switch (type) {
      case FeatureType.currentDebtor:
        return purchase.type.isCurrent && purchase.type.isDebtor;
      case FeatureType.currentCreditor:
        return purchase.type.isCurrent && purchase.type.isDebtor;
      case FeatureType.settledDebtor:
        return !purchase.type.isCurrent && !purchase.type.isDebtor;
      case FeatureType.settledCreditor:
        return !purchase.type.isCurrent && !purchase.type.isDebtor;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

  /// Devuelve si el tipo de feature es saldada
  ///
  /// Returns if the feature type is settled
  bool get isSettled => switch (this) {
        FeatureType.settledDebtor => true,
        FeatureType.settledCreditor => true,
        _ => false,
      };
}
