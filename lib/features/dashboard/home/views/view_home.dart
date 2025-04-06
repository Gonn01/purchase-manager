import 'package:flutter/material.dart';
import 'package:purchase_manager/features/dashboard/home/views/view_current_purchases.dart';
import 'package:purchase_manager/features/dashboard/home/views/view_settled_purchases.dart';

/// {@template ViewHome}
/// Vista principal de la pantalla de inicio
///
/// Main view of the home screen
/// {@endtemplate}
class ViewHome extends StatefulWidget {
  /// {@macro ViewHome}
  const ViewHome({
    super.key,
  });

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: InkWell(
                onTap: () => _tabController.animateTo(0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: _tabController.index == 0
                      ? const Color(0xff00B3A3)
                      : Colors.transparent,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: _tabController.index == 0
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _tabController.index == 0 ? 1.0 : 0.0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff006F66),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () => _tabController.animateTo(1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: _tabController.index == 1
                      ? const Color(0xff00B3A3)
                      : Colors.transparent,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.history,
                            color: _tabController.index == 1
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _tabController.index == 1 ? 1.0 : 0.0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff006F66),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ViewCurrentPurchases(
                index: _tabController.index,
              ),
              ViewSettledPurchases(
                index: _tabController.index,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
