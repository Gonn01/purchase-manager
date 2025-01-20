import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

      await auth.signInWithProvider(googleProvider);

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
