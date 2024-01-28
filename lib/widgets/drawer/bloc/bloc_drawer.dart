import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:purchase_manager/models/purchase.dart';

part 'bloc_drawer_event.dart';
part 'bloc_drawer_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDrawer extends Bloc<BlocDrawerEvent, BlocDrawerState> {
  /// {@macro BlocInicio}
  BlocDrawer() : super(const BlocDrawerState()) {
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
    emit(state.copyWith(estado: Status.loading));
    try {
      await auth.signOut();
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }
}
