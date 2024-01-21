import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/models/purchase.dart';

enum FeatureType {
  dashboard,
  currentDebtor,
  currentCreditor,
  settledDebtor,
  settledCreditor,
  categories;

  String get name => switch (this) {
        FeatureType.currentDebtor || FeatureType.currentCreditor => 'Vigente',
        FeatureType.settledDebtor || FeatureType.settledCreditor => 'Historial',
        FeatureType.dashboard => 'Dashboard',
        FeatureType.categories => 'Categoria',
      };

  String get featureName => switch (this) {
        FeatureType.currentDebtor ||
        FeatureType.currentCreditor =>
          RutaCurrentPurchases.name,
        FeatureType.settledDebtor ||
        FeatureType.settledCreditor =>
          RutaSettledPurchases.name,
        FeatureType.dashboard => RutaDashboard.name,
        FeatureType.categories => RutaFinancialEntities.name,
      };

  bool getBooleanValue(FeatureType type, Purchase purchase) {
    switch (type) {
      case FeatureType.currentDebtor:
        return purchase.current && purchase.debt;
      case FeatureType.currentCreditor:
        return purchase.current && !purchase.debt;
      case FeatureType.settledDebtor:
        return !purchase.current && purchase.debt;
      case FeatureType.settledCreditor:
        return !purchase.current && !purchase.debt;
      default:
        return false;
    }
  }

  bool get isSettled => switch (this) {
        FeatureType.settledDebtor => true,
        FeatureType.settledCreditor => true,
        _ => false,
      };
}
