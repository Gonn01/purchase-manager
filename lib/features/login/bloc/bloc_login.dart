import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/models/enums/status.dart';

part 'bloc_login_state.dart';
part 'bloc_login_event.dart';

/// {@template BlocLogin}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocLogin extends Bloc<BlocLoginEvent, BlocLoginState> {
  /// {@macro BlocLogin}
  BlocLogin() : super(const BlocLoginState()) {
    on<BlocLoginEventInitialize>(_onInitialize);
  }

  Future<void> _onInitialize(
    BlocLoginEventInitialize event,
    Emitter<BlocLoginState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      await auth.signInWithProvider(googleProvider);

      emit(
        state.copyWith(
          status: Status.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      debugPrint('Error al iniciar sesión con Google: $e');
    }
  }
}
