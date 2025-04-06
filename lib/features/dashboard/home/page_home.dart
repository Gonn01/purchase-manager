import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/views/view_home.dart';

@RoutePage()

/// {@template PageHome}
/// Pagina que contiene el home
///
/// Page that contains the home
/// {@endtemplate}
class PageHome extends StatefulWidget {
  /// {@macro PageHome}
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocHome()..add(BlocHomeEventInitialize()),
      child: const ViewHome(),
    );
  }
}
