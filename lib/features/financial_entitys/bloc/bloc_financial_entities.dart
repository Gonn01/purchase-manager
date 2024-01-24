import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/endpoints/crud_financial_entity.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:purchase_manager/models/financial_entity.dart';

part 'bloc_financial_entities_event.dart';
part 'bloc_financial_entities_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocFinancialEntities
    extends Bloc<BlocFinancialEntitiesEvento, BlocFinancialEntitiesState> {
  /// {@macro BlocInicio}
  BlocFinancialEntities() : super(const BlocFinancialEntitiesState()) {
    on<BlocFinancialEntitiesEventInitialize>(_onInitialize);
    on<BlocFinancialEntitiesEventSelectFinancialEntity>(
      _onSelectFinancialEntity,
    );
    on<BlocFinancialEntitiesEventCreateFinancialEntity>(
      _onCreateFinancialEntity,
    );
    on<BlocFinancialEntitiesEventDeleteFinancialEntity>(
      _onDeleteFinancialEntity,
    );

    add(BlocFinancialEntitiesEventInitialize());
  }

  Future<void> _onInitialize(
    BlocFinancialEntitiesEventInitialize event,
    Emitter<BlocFinancialEntitiesState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;

      final listFinancialEntitys =
          await readFinancialEntities(idUser: auth.currentUser?.uid ?? '');

      emit(
        state.copyWith(
          estado: Status.success,
          listFinancialEntities: listFinancialEntitys,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onCreateFinancialEntity(
    BlocFinancialEntitiesEventCreateFinancialEntity event,
    Emitter<BlocFinancialEntitiesState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;

      await createFinancialEntity(
        financialEntityName: event.financialEntityName,
        idUser: auth.currentUser?.uid ?? '',
      );

      add(BlocFinancialEntitiesEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocFinancialEntitiesEventDeleteFinancialEntity event,
    Emitter<BlocFinancialEntitiesState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;

      await deleteFinancialEntity(
        idFinancialEntity: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );

      add(BlocFinancialEntitiesEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  void _onSelectFinancialEntity(
    BlocFinancialEntitiesEventSelectFinancialEntity event,
    Emitter<BlocFinancialEntitiesState> emit,
  ) {
    add(BlocFinancialEntitiesEventInitialize());
    emit(state.copyWith(financialEntitySelected: event.financialEntity));
  }
}
