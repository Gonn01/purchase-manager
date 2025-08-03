import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_manager/features/auth/login/repository/auth_repository.dart';
import 'package:purchase_manager/utilities/models/exception.dart';
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
      final loginResponse = await AuthRepository.login(
        firebaseUserId: auth.currentUser!.uid,
        email: auth.currentUser!.email,
        name: auth.currentUser!.displayName,
      );
      await preferences.setString('token', loginResponse.body?.token ?? '');
      await preferences.setInt('user_id', loginResponse.body?.id ?? 0);

      emit(BlocLoginStateSuccess.from(state));
    } on Exception catch (e) {
      emit(
        BlocLoginStateError.from(
          state,
          exception: e is CustomException
              ? e
              : CustomException(
                  title: e.toString(),
                  message: 'An error occurred during initialization.',
                ),
        ),
      );
    }
  }
}
