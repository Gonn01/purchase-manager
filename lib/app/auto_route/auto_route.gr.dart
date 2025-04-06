// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:purchase_manager/features/auth/login/page_login.dart' as _i5;
import 'package:purchase_manager/features/dashboard/financial_entity_details/page_financial_entity_details.dart'
    as _i3;
import 'package:purchase_manager/features/dashboard/financial_entity_list/page_financial_entities_list.dart'
    as _i2;
import 'package:purchase_manager/features/dashboard/home/page_home.dart' as _i4;
import 'package:purchase_manager/features/dashboard/page_dashboard.dart' as _i1;
import 'package:purchase_manager/features/dashboard/purchase_details/page_purchase.dart'
    as _i6;

/// generated route for
/// [_i1.PageDashboard]
class RutaDashboard extends _i7.PageRouteInfo<void> {
  const RutaDashboard({List<_i7.PageRouteInfo>? children})
    : super(RutaDashboard.name, initialChildren: children);

  static const String name = 'RutaDashboard';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.PageDashboard();
    },
  );
}

/// generated route for
/// [_i2.PageFinancialEntitiesList]
class RutaFinancialEntitiesList extends _i7.PageRouteInfo<void> {
  const RutaFinancialEntitiesList({List<_i7.PageRouteInfo>? children})
    : super(RutaFinancialEntitiesList.name, initialChildren: children);

  static const String name = 'RutaFinancialEntitiesList';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageFinancialEntitiesList();
    },
  );
}

/// generated route for
/// [_i3.PageFinancialEntityDetails]
class RutaFinancialEntityDetails
    extends _i7.PageRouteInfo<RutaFinancialEntityDetailsArgs> {
  RutaFinancialEntityDetails({
    required int idFinancialEntity,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         RutaFinancialEntityDetails.name,
         args: RutaFinancialEntityDetailsArgs(
           idFinancialEntity: idFinancialEntity,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'RutaFinancialEntityDetails';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RutaFinancialEntityDetailsArgs>();
      return _i3.PageFinancialEntityDetails(
        idFinancialEntity: args.idFinancialEntity,
        key: args.key,
      );
    },
  );
}

class RutaFinancialEntityDetailsArgs {
  const RutaFinancialEntityDetailsArgs({
    required this.idFinancialEntity,
    this.key,
  });

  final int idFinancialEntity;

  final _i8.Key? key;

  @override
  String toString() {
    return 'RutaFinancialEntityDetailsArgs{idFinancialEntity: $idFinancialEntity, key: $key}';
  }
}

/// generated route for
/// [_i4.PageHome]
class RutaHome extends _i7.PageRouteInfo<void> {
  const RutaHome({List<_i7.PageRouteInfo>? children})
    : super(RutaHome.name, initialChildren: children);

  static const String name = 'RutaHome';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.PageHome();
    },
  );
}

/// generated route for
/// [_i5.PageLogin]
class RutaLogin extends _i7.PageRouteInfo<void> {
  const RutaLogin({List<_i7.PageRouteInfo>? children})
    : super(RutaLogin.name, initialChildren: children);

  static const String name = 'RutaLogin';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.PageLogin();
    },
  );
}

/// generated route for
/// [_i6.PagePurchaseDetails]
class RutaPurchaseDetails extends _i7.PageRouteInfo<RutaPurchaseDetailsArgs> {
  RutaPurchaseDetails({
    required int idPurchase,
    required int idFinancialEntity,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         RutaPurchaseDetails.name,
         args: RutaPurchaseDetailsArgs(
           idPurchase: idPurchase,
           idFinancialEntity: idFinancialEntity,
           key: key,
         ),
         rawPathParams: {
           'idPurchase': idPurchase,
           'idFinancialEntity': idFinancialEntity,
         },
         initialChildren: children,
       );

  static const String name = 'RutaPurchaseDetails';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RutaPurchaseDetailsArgs>(
        orElse:
            () => RutaPurchaseDetailsArgs(
              idPurchase: pathParams.getInt('idPurchase'),
              idFinancialEntity: pathParams.getInt('idFinancialEntity'),
            ),
      );
      return _i6.PagePurchaseDetails(
        idPurchase: args.idPurchase,
        idFinancialEntity: args.idFinancialEntity,
        key: args.key,
      );
    },
  );
}

class RutaPurchaseDetailsArgs {
  const RutaPurchaseDetailsArgs({
    required this.idPurchase,
    required this.idFinancialEntity,
    this.key,
  });

  final int idPurchase;

  final int idFinancialEntity;

  final _i8.Key? key;

  @override
  String toString() {
    return 'RutaPurchaseDetailsArgs{idPurchase: $idPurchase, idFinancialEntity: $idFinancialEntity, key: $key}';
  }
}
