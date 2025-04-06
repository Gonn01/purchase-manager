import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_manager/features/auth/login/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_login_state.dart';
part 'bloc_login_event.dart';

/// {@template BlocLogin}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
///
/// Bloc that manages the states and logic of the 'Login' page
/// {@endtemplate}
class BlocLogin extends Bloc<BlocLoginEvent, BlocLoginState> {
  /// {@macro BlocLogin}
  BlocLogin() : super(BlocLoginStateInitial()) {
    on<BlocLoginEventLogin>(_onInitialize);
  }
  final authRepository = AuthRepository();

  Future<void> _onInitialize(
    BlocLoginEventLogin event,
    Emitter<BlocLoginState> emit,
  ) async {
    emit(BlocLoginStateLoading.from(state));
    try {
      final auth = FirebaseAuth.instance;

      final googleProvider = GoogleAuthProvider();

      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        await auth.signInWithProvider(googleProvider);
      }
      final preferences = await SharedPreferences.getInstance();
      final loginResponse = await authRepository.login(
        firebaseUserId: auth.currentUser!.uid,
        email: auth.currentUser!.email,
        name: auth.currentUser!.displayName,
      );
      await preferences.setInt('user_id', loginResponse.body);

      emit(BlocLoginStateSuccess.from(state));
    } on Exception catch (e) {
      emit(
        BlocLoginStateError.from(
          state,
          errorMessage: 'Error al iniciar sesión con Google: $e',
        ),
      );
    }
  }
}
