import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/features/dashboard/financial_entity_list/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/utilities/models/exception.dart';

part 'bloc_financial_entity_list_state.dart';
part 'bloc_financial_entity_list_event.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocFinancialEntityList
    extends Bloc<BlocFinancialEntityListEvent, BlocFinancialEntityListState> {
  /// {@macro BlocInicio}
  BlocFinancialEntityList() : super(BlocFinancialEntityListStateInitial()) {
    on<BlocFinancialEntityListEventInitialize>(_onInitialize);
    on<BlocFinancialEntityListEventDeleteFinancialEntity>(
      _onDeleteFinancialEntity,
    );
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  Future<void> _onInitialize(
    BlocFinancialEntityListEventInitialize event,
    Emitter<BlocFinancialEntityListState> emit,
  ) async {
    emit(BlocFinancialEntityListStateLoading.from(state));
    try {
      final responseListFinancialeEntity =
          await FinancialEntitiesRepository.getFinancialEntities();

      emit(
        BlocFinancialEntityListStateSuccess.from(
          state,
          financialEntityList: responseListFinancialeEntity.body,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocFinancialEntityListStateError.from(
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

  Future<void> _onDeleteFinancialEntity(
    BlocFinancialEntityListEventDeleteFinancialEntity event,
    Emitter<BlocFinancialEntityListState> emit,
  ) async {
    emit(BlocFinancialEntityListStateLoading.from(state));
    try {
      await FinancialEntitiesRepository.deleteFinancialEntity(
        financialEntityId: event.idFinancialEntity,
      );

      final list = List<FinancialEntityDto>.from(state.financialEntityList)
        ..removeWhere(
          (financialEntity) => financialEntity.id == event.idFinancialEntity,
        );

      emit(
        BlocFinancialEntityListStateSuccessDeletingFinancialEntity.from(
          state,
          financialEntityList: list,
          financialEntityDeletedId: event.idFinancialEntity,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocFinancialEntityListStateError.from(
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
