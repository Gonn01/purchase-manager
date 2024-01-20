import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/auto_route/auto_route.gr.dart';
import 'package:purchase_manager/features/login/bloc/bloc_login.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/models/status.dart';

class ViewLogin extends StatefulWidget {
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocLogin, BlocLoginState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          context.router.push(const RutaDashboard());
        }
      },
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () =>
                context.read<BlocLogin>().add(BlocLoginEventInitialize()),
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Center(
                child: Image.asset(
                  Assets.images.logoGoogle.path,
                  width: 80.0,
                  height: 80.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
