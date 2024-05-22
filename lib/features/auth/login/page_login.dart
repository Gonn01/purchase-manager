import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/auth/login/bloc/bloc_login.dart';
import 'package:purchase_manager/features/auth/login/views/view_login.dart';

@RoutePage()

/// {@template PageLogin}
/// Pagina que contiene el login
///
/// Page that contains the login
/// {@endtemplate}
class PageLogin extends StatefulWidget {
  /// {@macro PageLogin}
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocLogin(),
      child: const ViewLogin(),
    );
  }
}
