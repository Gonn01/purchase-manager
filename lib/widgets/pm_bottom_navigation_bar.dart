import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/models/enums/feature_type.dart';

class PMBottomNavigationBar extends StatelessWidget {
  const PMBottomNavigationBar({
    required this.type,
    super.key,
  });

  final FeatureType type;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => context.router.push(const RutaCurrentPurchase()),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: type == FeatureType.history
                        ? Colors.transparent
                        : const Color(0xff00B3A3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: type == FeatureType.history
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                ),
                if (type != FeatureType.history)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff006F66),
                    ),
                  )
              ],
            ),
          ),
          InkWell(
            onTap: () => context.router.push(const RutaHistory()),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: type == FeatureType.history
                        ? const Color(0xff00B3A3)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.history,
                      color: type == FeatureType.history
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
                if (type == FeatureType.history)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff006F66),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
