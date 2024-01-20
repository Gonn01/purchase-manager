import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/login/bloc/bloc_login.dart';
import 'package:purchase_manager/features/login/view/view_login.dart';

@RoutePage()
class PageLogin extends StatefulWidget {
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
