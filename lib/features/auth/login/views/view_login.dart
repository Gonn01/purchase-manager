import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/app/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/auth/login/bloc/bloc_login.dart';
import 'package:purchase_manager/gen/assets.gen.dart';

/// {@template ViewLogin}
/// Pagina que contiene el login
///
/// Page that contains the login
/// {@endtemplate}
class ViewLogin extends StatefulWidget {
  /// {@macro ViewLogin}
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocLogin, BlocLoginState>(
      listener: (context, state) {
        if (state is BlocLoginStateSuccess) {
          context.router.replace(const RutaHome());
        }
        if (state is BlocLoginStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? ''),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () => context.read<BlocLogin>().add(BlocLoginEventLogin()),
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  Assets.images.logoGoogle.path,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
