// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:purchase_manager/features/dashboard/current_purchases/page_debt.dart'
    as _i1;
import 'package:purchase_manager/features/dashboard/history_purchases/page_history.dart'
    as _i4;
import 'package:purchase_manager/features/dashboard/page_dashboard.dart' as _i2;
import 'package:purchase_manager/features/dashboard/financial_entitys/page_financial_entities.dart'
    as _i3;
import 'package:purchase_manager/features/login/page_login.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    RutaCurrentPurchase.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PageCurrentPurchase(),
      );
    },
    RutaDashboard.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PageDashboard(),
      );
    },
    RutaFinancialEntitys.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PageFinancialEntities(),
      );
    },
    RutaHistory.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PageHistory(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PageLogin(),
      );
    },
  };
}

/// generated route for
/// [_i1.PageCurrentPurchase]
class RutaCurrentPurchase extends _i6.PageRouteInfo<void> {
  const RutaCurrentPurchase({List<_i6.PageRouteInfo>? children})
      : super(
          RutaCurrentPurchase.name,
          initialChildren: children,
        );

  static const String name = 'RutaCurrentPurchase';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PageDashboard]
class RutaDashboard extends _i6.PageRouteInfo<void> {
  const RutaDashboard({List<_i6.PageRouteInfo>? children})
      : super(
          RutaDashboard.name,
          initialChildren: children,
        );

  static const String name = 'RutaDashboard';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageFinancialEntities]
class RutaFinancialEntitys extends _i6.PageRouteInfo<void> {
  const RutaFinancialEntitys({List<_i6.PageRouteInfo>? children})
      : super(
          RutaFinancialEntitys.name,
          initialChildren: children,
        );

  static const String name = 'RutaFinancialEntitys';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PageHistory]
class RutaHistory extends _i6.PageRouteInfo<void> {
  const RutaHistory({List<_i6.PageRouteInfo>? children})
      : super(
          RutaHistory.name,
          initialChildren: children,
        );

  static const String name = 'RutaHistory';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PageLogin]
class RutaLogin extends _i6.PageRouteInfo<void> {
  const RutaLogin({List<_i6.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
