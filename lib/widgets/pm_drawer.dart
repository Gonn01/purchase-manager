import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/widgets/pm_buttons.dart';

class PMDrawer extends StatelessWidget {
  const PMDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff02B3A3),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          auth.currentUser?.photoURL ?? '',
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(Assets.images.user.path),
                        )),
                    Text(auth.currentUser?.email ?? '')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DrawerButtons(
                    label: 'Comprsas Vigentes',
                    onTap: () {
                      context.router.push(const RutaCurrentPurchase());
                      Scaffold.of(context).closeDrawer();
                    },
                  ),
                  _DrawerButtons(
                    label: 'Historial de comprsas',
                    onTap: () {
                      context.router.push(const RutaHistory());
                      Scaffold.of(context).closeDrawer();
                    },
                  ),
                  _DrawerButtons(
                    label: 'Categorias',
                    onTap: () {
                      context.router.push(const RutaFinancialEntitys());
                      Scaffold.of(context).closeDrawer();
                    },
                  ),
                ],
              ),
            ),
            Container(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: PMButtons.text(
                  text: 'Cerrar sesión',
                  backgroundColor: Colors.redAccent,
                  isEnabled: true,
                  onTap: () async {
                    await auth.signOut();
                    context.router.push(const RutaLogin());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerButtons extends StatelessWidget {
  const _DrawerButtons({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
