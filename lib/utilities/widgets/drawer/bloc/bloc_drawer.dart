import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'bloc_drawer_event.dart';
part 'bloc_drawer_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDrawer extends Bloc<BlocDrawerEvent, BlocDrawerState> {
  /// {@macro BlocInicio}
  BlocDrawer() : super(BlocDrawerStateInitial()) {
    on<BlocDrawerEventSignOut>(_onSignOut);
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  Future<void> _onSignOut(
    BlocDrawerEventSignOut event,
    Emitter<BlocDrawerState> emit,
  ) async {
    emit(BlocDrawerStateLoading.from(state));
    try {
      await auth.signOut();
      emit(BlocDrawerStateSuccess.from(state));
    } on Exception catch (e) {
      emit(BlocDrawerStateError.from(state, error: e.toString()));
    }
  }
}
