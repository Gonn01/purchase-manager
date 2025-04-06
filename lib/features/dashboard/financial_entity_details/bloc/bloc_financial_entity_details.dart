import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/logs.dart';

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
  final auth = FirebaseAuth.instance;

  final _financialEntitiesRepository = FinancialEntitiesRepository();

  Future<void> _onInitialize(
    BlocFinancialEntityDetailsEventInitialize event,
    Emitter<BlocFinancialEntityDetailsState> emit,
  ) async {
    emit(BlocFinancialEntityDetailsStateLoading.from(state));
    try {
      final financialEntity =
          await _financialEntitiesRepository.getFinancialEntity(
        financialEntityId: event.financialEntityId,
      );
      final lastMovements = await _financialEntitiesRepository.getLastMovements(
        financialEntityId: event.financialEntityId,
      );
      emit(
        BlocFinancialEntityDetailsStateSuccess.from(
          financialEntity: financialEntity.body,
          lastMovements: lastMovements.body,
          state,
        ),
      );
    } on CustomException catch (e) {
      emit(BlocFinancialEntityDetailsStateError.from(state, e.message));
    }
  }
}
