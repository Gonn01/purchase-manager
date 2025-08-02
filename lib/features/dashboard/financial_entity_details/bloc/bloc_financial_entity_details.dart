import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_details/dtos/financial_entity_details_dto.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/utilities/models/exception.dart';

part 'bloc_financial_entity_details_event.dart';
part 'bloc_financial_entity_details_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocFinancialEntityDetails extends Bloc<BlocFinancialEntityDetailsEvent,
    BlocFinancialEntityDetailsState> {
  /// {@macro BlocInicio}
  BlocFinancialEntityDetails()
      : super(BlocFinancialEntityDetailsStateInitial()) {
    on<BlocFinancialEntityDetailsEventInitialize>(_onInitialize);
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _onInitialize(
    BlocFinancialEntityDetailsEventInitialize event,
    Emitter<BlocFinancialEntityDetailsState> emit,
  ) async {
    emit(BlocFinancialEntityDetailsStateLoading.from(state));
    try {
      final financialEntity =
          await FinancialEntitiesRepository.getFinancialEntity();
      emit(
        BlocFinancialEntityDetailsStateSuccess.from(
          financialEntity: financialEntity.body,
          state,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocFinancialEntityDetailsStateError.from(
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
