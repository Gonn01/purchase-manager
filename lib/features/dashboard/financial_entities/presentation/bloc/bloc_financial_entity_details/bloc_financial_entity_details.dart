import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/data/dtos/financial_entity_details_dto.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/data/repository/financial_entity_repository.dart';
import 'package:purchase_manager/utilities/models/exception.dart';

part 'bloc_financial_entity_details_state.dart';
part 'bloc_financial_entity_details_event.dart';

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

  Future<void> _onInitialize(
    BlocFinancialEntityDetailsEventInitialize event,
    Emitter<BlocFinancialEntityDetailsState> emit,
  ) async {
    emit(BlocFinancialEntityDetailsStateLoading.from(state));
    try {
      final financialEntity =
          await FinancialEntityListRepository.getFinancialEntityDetails(
              financialEntityId: event.financialEntityId);
      emit(
        BlocFinancialEntityDetailsStateSuccess.from(
          financialEntityDetails: financialEntity.body,
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
