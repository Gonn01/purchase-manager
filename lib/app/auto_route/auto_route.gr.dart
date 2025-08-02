// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:purchase_manager/features/auth/login/page_login.dart' as _i3;
import 'package:purchase_manager/features/dashboard/home/page_home.dart' as _i2;
import 'package:purchase_manager/features/dashboard/page_dashboard.dart' as _i1;
import 'package:purchase_manager/features/dashboard/purchase_details/page_purchase.dart'
    as _i4;

/// generated route for
/// [_i1.PageDashboard]
class RutaDashboard extends _i5.PageRouteInfo<void> {
  const RutaDashboard({List<_i5.PageRouteInfo>? children})
      : super(RutaDashboard.name, initialChildren: children);

  static const String name = 'RutaDashboard';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.PageDashboard();
    },
  );
}

/// generated route for
/// [_i2.PageHome]
class RutaHome extends _i5.PageRouteInfo<void> {
  const RutaHome({List<_i5.PageRouteInfo>? children})
      : super(RutaHome.name, initialChildren: children);

  static const String name = 'RutaHome';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageHome();
    },
  );
}

/// generated route for
/// [_i3.PageLogin]
class RutaLogin extends _i5.PageRouteInfo<void> {
  const RutaLogin({List<_i5.PageRouteInfo>? children})
      : super(RutaLogin.name, initialChildren: children);

  static const String name = 'RutaLogin';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PageLogin();
    },
  );
}

/// generated route for
/// [_i4.PagePurchaseDetails]
class RutaPurchaseDetails extends _i5.PageRouteInfo<RutaPurchaseDetailsArgs> {
  RutaPurchaseDetails({
    required int idPurchase,
    required int idFinancialEntity,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
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

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RutaPurchaseDetailsArgs>(
        orElse: () => RutaPurchaseDetailsArgs(
          idPurchase: pathParams.getInt('idPurchase'),
          idFinancialEntity: pathParams.getInt('idFinancialEntity'),
        ),
      );
      return _i4.PagePurchaseDetails(
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

  final _i6.Key? key;

  @override
  String toString() {
    return 'RutaPurchaseDetailsArgs{idPurchase: $idPurchase, idFinancialEntity: $idFinancialEntity, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RutaPurchaseDetailsArgs) return false;
    return idPurchase == other.idPurchase &&
        idFinancialEntity == other.idFinancialEntity &&
        key == other.key;
  }

  @override
  int get hashCode =>
      idPurchase.hashCode ^ idFinancialEntity.hashCode ^ key.hashCode;
}
