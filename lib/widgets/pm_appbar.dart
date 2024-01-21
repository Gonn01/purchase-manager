import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/dialogs/dialog_create_financial_entity.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

class PMAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PMAppbar({
    required this.type,
    super.key,
  });

  Future<void> _createFinancialEntity(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: const DialogCreateFinancialEntity(),
      ),
    );
  }

  final FeatureType type;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 80);

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
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ),
      ),
      actions: [
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
      bottom: type != FeatureType.categories
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
