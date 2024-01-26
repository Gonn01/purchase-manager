// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:purchase_manager/features/financial_entitys/financial_entities_list/page_financial_entities_list.dart'
    as _i3;
import 'package:purchase_manager/features/financial_entitys/financial_entity_details/page_financial_entity_details.dart'
    as _i4;
import 'package:purchase_manager/features/financial_entitys/page_financial_entities.dart'
    as _i2;
import 'package:purchase_manager/features/home/current_purchases/page_current_purchases.dart'
    as _i1;
import 'package:purchase_manager/features/home/page_dashboard.dart' as _i5;
import 'package:purchase_manager/features/home/settled_purchases/page_settled_purchases.dart'
    as _i8;
import 'package:purchase_manager/features/login/page_login.dart' as _i6;
import 'package:purchase_manager/features/purchase_details/page_purchase.dart'
    as _i7;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    RutaCurrentPurchases.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PageCurrentPurchases(),
      );
    },
    RutaFinancialEntities.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PageFinancialEntities(),
      );
    },
    RutaFinancialEntitiesList.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PageFinancialEntitiesList(),
      );
    },
    RutaFinancialEntityDetails.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PageFinancialEntityDetails(),
      );
    },
    RutaHome.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PageHome(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PageLogin(),
      );
    },
    RutaPurchaseDetails.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPurchaseDetailsArgs>(
          orElse: () => RutaPurchaseDetailsArgs(
              idPurchase: pathParams.getString('idPurchase')));
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.PagePurchaseDetails(
          idPurchase: args.idPurchase,
          key: args.key,
        ),
      );
    },
    RutaSettledPurchases.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PageSettledPurchases(),
      );
    },
  };
}

/// generated route for
/// [_i1.PageCurrentPurchases]
class RutaCurrentPurchases extends _i9.PageRouteInfo<void> {
  const RutaCurrentPurchases({List<_i9.PageRouteInfo>? children})
      : super(
          RutaCurrentPurchases.name,
          initialChildren: children,
        );

  static const String name = 'RutaCurrentPurchases';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PageFinancialEntities]
class RutaFinancialEntities extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntities({List<_i9.PageRouteInfo>? children})
      : super(
          RutaFinancialEntities.name,
          initialChildren: children,
        );

  static const String name = 'RutaFinancialEntities';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageFinancialEntitiesList]
class RutaFinancialEntitiesList extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntitiesList({List<_i9.PageRouteInfo>? children})
      : super(
          RutaFinancialEntitiesList.name,
          initialChildren: children,
        );

  static const String name = 'RutaFinancialEntitiesList';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PageFinancialEntityDetails]
class RutaFinancialEntityDetails extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntityDetails({List<_i9.PageRouteInfo>? children})
      : super(
          RutaFinancialEntityDetails.name,
          initialChildren: children,
        );

  static const String name = 'RutaFinancialEntityDetails';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PageHome]
class RutaHome extends _i9.PageRouteInfo<void> {
  const RutaHome({List<_i9.PageRouteInfo>? children})
      : super(
          RutaHome.name,
          initialChildren: children,
        );

  static const String name = 'RutaHome';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PageLogin]
class RutaLogin extends _i9.PageRouteInfo<void> {
  const RutaLogin({List<_i9.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PagePurchaseDetails]
class RutaPurchaseDetails extends _i9.PageRouteInfo<RutaPurchaseDetailsArgs> {
  RutaPurchaseDetails({
    required String idPurchase,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          RutaPurchaseDetails.name,
          args: RutaPurchaseDetailsArgs(
            idPurchase: idPurchase,
            key: key,
          ),
          rawPathParams: {'idPurchase': idPurchase},
          initialChildren: children,
        );

  static const String name = 'RutaPurchaseDetails';

  static const _i9.PageInfo<RutaPurchaseDetailsArgs> page =
      _i9.PageInfo<RutaPurchaseDetailsArgs>(name);
}

class RutaPurchaseDetailsArgs {
  const RutaPurchaseDetailsArgs({
    required this.idPurchase,
    this.key,
  });

  final String idPurchase;

  final _i10.Key? key;

  @override
  String toString() {
    return 'RutaPurchaseDetailsArgs{idPurchase: $idPurchase, key: $key}';
  }
}

/// generated route for
/// [_i8.PageSettledPurchases]
class RutaSettledPurchases extends _i9.PageRouteInfo<void> {
  const RutaSettledPurchases({List<_i9.PageRouteInfo>? children})
      : super(
          RutaSettledPurchases.name,
          initialChildren: children,
        );

  static const String name = 'RutaSettledPurchases';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
