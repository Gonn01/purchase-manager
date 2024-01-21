import 'package:purchase_manager/auto_route/auto_route.gr.dart';

enum FeatureType {
  dashboard,
  current,
  history,
  categories;

  String get name => switch (this) {
        FeatureType.dashboard => 'Dashboard',
        FeatureType.current => 'Vigente',
        FeatureType.history => 'Historial',
        FeatureType.categories => 'Categoria',
      };
  String get featureName => switch (this) {
        FeatureType.dashboard => RutaDashboard.name,
        FeatureType.current => RutaCurrentPurchase.name,
        FeatureType.history => RutaHistory.name,
        FeatureType.categories => RutaFinancialEntitys.name,
      };
}
