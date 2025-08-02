import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/exception.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_financial_entity_list_state.dart';
part 'bloc_financial_entity_list_event.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocFinancialEntityList
    extends Bloc<BlocFinancialEntityListEvent, BlocFinancialEntityListState> {
  /// {@macro BlocInicio}
  BlocFinancialEntityList() : super(BlocFinancialEntityListStateInitial()) {
    on<BlocFinancialEntityListEventInitialize>(
      _onInitialize,
    );
    on<BlocFinancialEntityListEventDeleteFinancialEntity>(
      _onDeleteFinancialEntity,
    );
    on<BlocFinancialEntityListEventAddFinancialEntity>(
      _onAddFinancialEntity,
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
      final preferences = await SharedPreferences.getInstance();

      final userId = preferences.getInt(Config.userId) ?? 0;

      final responseListFinancialeEntity =
          await FinancialEntitiesRepository.getFinancialEntities(
              userId: userId);

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

      final list = List<FinancialEntity>.from(state.financialEntityList)
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

  Future<void> _onAddFinancialEntity(
    BlocFinancialEntityListEventAddFinancialEntity event,
    Emitter<BlocFinancialEntityListState> emit,
  ) async {
    emit(BlocFinancialEntityListStateLoading.from(state));
    try {
      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..add(event.financialEntity);

      emit(
        BlocFinancialEntityListStateSuccess.from(
          state,
          financialEntityList: list,
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
