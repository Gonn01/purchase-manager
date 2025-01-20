// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:purchase_manager/features/auth/login/page_login.dart' as _i6;
import 'package:purchase_manager/features/financial_entitys/page_financial_entities.dart'
    as _i2;
import 'package:purchase_manager/features/financial_entitys/views/financial_entities_list/page_financial_entities_list.dart'
    as _i3;
import 'package:purchase_manager/features/financial_entitys/views/financial_entity_details/page_financial_entity_details.dart'
    as _i4;
import 'package:purchase_manager/features/home/page_home.dart' as _i5;
import 'package:purchase_manager/features/home/views/current_purchases/page_current_purchases.dart'
    as _i1;
import 'package:purchase_manager/features/home/views/settled_purchases/page_settled_purchases.dart'
    as _i8;
import 'package:purchase_manager/features/purchase_details/page_purchase.dart'
    as _i7;

/// generated route for
/// [_i1.PageCurrentPurchases]
class RutaCurrentPurchases extends _i9.PageRouteInfo<void> {
  const RutaCurrentPurchases({List<_i9.PageRouteInfo>? children})
    : super(RutaCurrentPurchases.name, initialChildren: children);

  static const String name = 'RutaCurrentPurchases';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.PageCurrentPurchases();
    },
  );
}

/// generated route for
/// [_i2.PageFinancialEntities]
class RutaFinancialEntities extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntities({List<_i9.PageRouteInfo>? children})
    : super(RutaFinancialEntities.name, initialChildren: children);

  static const String name = 'RutaFinancialEntities';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageFinancialEntities();
    },
  );
}

/// generated route for
/// [_i3.PageFinancialEntitiesList]
class RutaFinancialEntitiesList extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntitiesList({List<_i9.PageRouteInfo>? children})
    : super(RutaFinancialEntitiesList.name, initialChildren: children);

  static const String name = 'RutaFinancialEntitiesList';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.PageFinancialEntitiesList();
    },
  );
}

/// generated route for
/// [_i4.PageFinancialEntityDetails]
class RutaFinancialEntityDetails extends _i9.PageRouteInfo<void> {
  const RutaFinancialEntityDetails({List<_i9.PageRouteInfo>? children})
    : super(RutaFinancialEntityDetails.name, initialChildren: children);

  static const String name = 'RutaFinancialEntityDetails';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.PageFinancialEntityDetails();
    },
  );
}

/// generated route for
/// [_i5.PageHome]
class RutaHome extends _i9.PageRouteInfo<void> {
  const RutaHome({List<_i9.PageRouteInfo>? children})
    : super(RutaHome.name, initialChildren: children);

  static const String name = 'RutaHome';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.PageHome();
    },
  );
}

/// generated route for
/// [_i6.PageLogin]
class RutaLogin extends _i9.PageRouteInfo<void> {
  const RutaLogin({List<_i9.PageRouteInfo>? children})
    : super(RutaLogin.name, initialChildren: children);

  static const String name = 'RutaLogin';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.PageLogin();
    },
  );
}

/// generated route for
/// [_i7.PagePurchaseDetails]
class RutaPurchaseDetails extends _i9.PageRouteInfo<RutaPurchaseDetailsArgs> {
  RutaPurchaseDetails({
    required String idPurchase,
    required String idFinancialEntity,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
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

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RutaPurchaseDetailsArgs>(
        orElse:
            () => RutaPurchaseDetailsArgs(
              idPurchase: pathParams.getString('idPurchase'),
              idFinancialEntity: pathParams.getString('idFinancialEntity'),
            ),
      );
      return _i7.PagePurchaseDetails(
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

  final String idPurchase;

  final String idFinancialEntity;

  final _i10.Key? key;

  @override
  String toString() {
    return 'RutaPurchaseDetailsArgs{idPurchase: $idPurchase, idFinancialEntity: $idFinancialEntity, key: $key}';
  }
}

/// generated route for
/// [_i8.PageSettledPurchases]
class RutaSettledPurchases extends _i9.PageRouteInfo<void> {
  const RutaSettledPurchases({List<_i9.PageRouteInfo>? children})
    : super(RutaSettledPurchases.name, initialChildren: children);

  static const String name = 'RutaSettledPurchases';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.PageSettledPurchases();
    },
  );
}
