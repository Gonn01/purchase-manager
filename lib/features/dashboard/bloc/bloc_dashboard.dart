import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/exception.dart';
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

    on<BlocDashboardEventCreateFinancialEntity>((event, emit) {
      emit(BlocDashboardStateCreateFinancialEntityTriggered.from(state));
    });
    on<BlocDashboardEventCreatePurchase>((event, emit) =>
        emit(BlocDashboardStateSuccessCreatePurchaseTriggered.from(state)));

    add(BlocDashboardEventInitialize());
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _onSignOut(
    BlocDashboardEventSignOut event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      await auth.signOut();
      emit(BlocDashboardStateSuccessSignOut.from(state));
    } on Exception catch (e) {
      emit(
        BlocDashboardStateError.from(
          state,
          exception: e is CustomException
              ? e
              : CustomException(
                  title: e.toString(),
                  message: 'An error occurred during processing.',
                ),
        ),
      );
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

      final dolar = await DolarService.getDollarData();

      emit(
        BlocDashboardStateSuccess.from(
          state,
          currency: dolar,
          selectedCurrency: currencyTypeSelected,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocDashboardStateError.from(
          state,
          exception: e is CustomException
              ? e
              : CustomException(
                  title: e.toString(),
                  message: 'An error occurred during processing.',
                ),
        ),
      );
    }
  }

  Future<void> _onSelectCurrency(
    BlocDashboardEventSelectCurrency event,
    Emitter<BlocDashboardState> emit,
  ) async {
    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.setInt('currency', event.selectedCurrency.value);

      emit(
        BlocDashboardStateSuccess.from(
          state,
          selectedCurrency: event.selectedCurrency,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocDashboardStateError.from(
          state,
          exception: e is CustomException
              ? e
              : CustomException(
                  title: e.toString(),
                  message: 'An error occurred during processing.',
                ),
        ),
      );
    }
  }
}
