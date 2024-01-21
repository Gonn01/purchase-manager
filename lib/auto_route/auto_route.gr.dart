// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:purchase_manager/features/home/current_purchases/page_current_purchases.dart'
    as _i1;
import 'package:purchase_manager/features/home/financial_entitys/page_financial_entities.dart'
    as _i2;
import 'package:purchase_manager/features/home/page_dashboard.dart' as _i3;
import 'package:purchase_manager/features/home/settled_purchases/page_settled_purchases.dart'
    as _i5;
import 'package:purchase_manager/features/login/page_login.dart' as _i4;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    RutaCurrentPurchases.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PageCurrentPurchases(),
      );
    },
    RutaFinancialEntities.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PageFinancialEntities(),
      );
    },
    RutaHome.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PageHome(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PageLogin(),
      );
    },
    RutaSettledPurchases.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PageSettledPurchases(),
      );
    },
  };
}

/// generated route for
/// [_i1.PageCurrentPurchases]
class RutaCurrentPurchases extends _i6.PageRouteInfo<void> {
  const RutaCurrentPurchases({List<_i6.PageRouteInfo>? children})
      : super(
          RutaCurrentPurchases.name,
          initialChildren: children,
        );

  static const String name = 'RutaCurrentPurchases';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PageFinancialEntities]
class RutaFinancialEntities extends _i6.PageRouteInfo<void> {
  const RutaFinancialEntities({List<_i6.PageRouteInfo>? children})
      : super(
          RutaFinancialEntities.name,
          initialChildren: children,
        );

  static const String name = 'RutaFinancialEntities';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageHome]
class RutaHome extends _i6.PageRouteInfo<void> {
  const RutaHome({List<_i6.PageRouteInfo>? children})
      : super(
          RutaHome.name,
          initialChildren: children,
        );

  static const String name = 'RutaHome';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PageLogin]
class RutaLogin extends _i6.PageRouteInfo<void> {
  const RutaLogin({List<_i6.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PageSettledPurchases]
class RutaSettledPurchases extends _i6.PageRouteInfo<void> {
  const RutaSettledPurchases({List<_i6.PageRouteInfo>? children})
      : super(
          RutaSettledPurchases.name,
          initialChildren: children,
        );

  static const String name = 'RutaSettledPurchases';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
