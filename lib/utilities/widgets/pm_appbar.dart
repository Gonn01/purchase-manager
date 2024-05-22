import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/dialogs/dialog_create_financial_entity.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';

/// {@template PMAppbar}
/// Appbar de la aplicacion
///
/// Application appbar
/// {@endtemplate}
class PMAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro PMAppbar}
  const PMAppbar({
    required this.type,
    super.key,
  });

  Future<void> _createFinancialEntity(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: const DialogCreateFinancialEntity(),
      ),
    );
  }

  /// Tipo de feature
  final FeatureType type;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight +
            (type != FeatureType.financialEntities &&
                    type != FeatureType.financialEntityDetails &&
                    type != FeatureType.financialEntitiesList &&
                    type != FeatureType.purchaseDetails
                ? 80
                : 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff02B3A3),
      title: Text(
        type.name,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      leading: (type != FeatureType.financialEntityDetails &&
              type != FeatureType.purchaseDetails)
          ? IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            )
          : IconButton(
              onPressed: () => context.router.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
      actions: [
        if (type != FeatureType.financialEntities &&
            type != FeatureType.financialEntityDetails &&
            type != FeatureType.financialEntitiesList &&
            type != FeatureType.purchaseDetails)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => _createFinancialEntity(context),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
      ],
      bottom: type != FeatureType.financialEntities &&
              type != FeatureType.financialEntityDetails &&
              type != FeatureType.financialEntitiesList &&
              type != FeatureType.purchaseDetails
          ? const TabBar(
              indicatorWeight: 5,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.money_off),
                  child: Text(
                    'Debo 🥲',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.monetization_on),
                  child: Text(
                    'Me deben 😀',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
