import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/services/currency_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_dashboard_event.dart';
part 'bloc_dashboard_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvent, BlocDashboardState> {
  /// {@macro BlocInicio}
  BlocDashboard() : super(BlocDashboardStateInitial()) {
    on<BlocDashboardEventSignOut>(_onSignOut);
    on<BlocDashboardEventInitialize>(_onInitialize);
    on<BlocDashboardEventSelectCurrency>(_onSelectCurrency);
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  Future<void> _onSignOut(
    BlocDashboardEventSignOut event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      await auth.signOut();
      emit(BlocDashboardStateSuccessSignOut.from(state));
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onInitialize(
    BlocDashboardEventInitialize event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      final preferences = await SharedPreferences.getInstance();

      final currencyTypeValue = preferences.getInt('currency');

      final currencyTypeSelected = CurrencyType.type(currencyTypeValue ?? 0);

      final dolar = await DolarService().getDollarData();

      emit(
        BlocDashboardStateSuccess.from(
          state,
          currency: dolar,
          selectedCurrency: currencyTypeSelected,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onSelectCurrency(
    BlocDashboardEventSelectCurrency event,
    Emitter<BlocDashboardState> emit,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt('currency', event.selectedCurrency.value);

    emit(
      BlocDashboardStateSuccess.from(
        state,
        selectedCurrency: event.selectedCurrency,
      ),
    );
  }
}
