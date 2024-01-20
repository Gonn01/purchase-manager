import 'package:bloc/bloc.dart';
import 'package:purchase_manager/endpoints/crud_financial_entity.dart';
import 'package:purchase_manager/endpoints/crud_purchase.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:purchase_manager/models/status.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'bloc_dashboard_state.dart';
part 'bloc_dashboard_event.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvento, BlocDashboardState> {
  /// {@macro BlocInicio}
  BlocDashboard() : super(const BlocDashboardState()) {
    on<BlocDashboardEventInitialize>(_onInitialize);
    on<BlocDashboardEventModifyAmountOfQuotas>(_onModifyAmountOfQuotas);
    on<BlocDashboardEventCreateFinancialEntity>(_onCreateFinancialEntity);
    on<BlocDashboardEventDeleteFinancialEntity>(_onDeleteFinancialEntity);
    on<BlocDashboardEventCreatePurchase>(_onCreatePurchase);
    on<BlocDashboardEventEditPurchase>(_onEditPurchase);
    on<BlocDashboardEventDeletePurchase>(_onDeletePurchase);

    add(BlocDashboardEventInitialize());
  }

  Future<void> _onInitialize(
    BlocDashboardEventInitialize event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      final listaCategorias =
          await readFinancialEntities(idUser: auth.currentUser?.uid ?? '');

      emit(
        state.copyWith(
          estado: Status.success,
          listaCategorias: listaCategorias,
        ),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onModifyAmountOfQuotas(
    BlocDashboardEventModifyAmountOfQuotas event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      final listaCategorias =
          List<FinancialEntity>.from(state.financialEntityList);

      // Busca la categoría que contiene la compra con la ID proporcionada
      final categoriaModificada = listaCategorias.firstWhere(
        (categoria) =>
            categoria.purchases.any((compra) => compra.id == event.idPurchase),
      );

      // Modifica la cantidad de cuotas directamente en la compra dentro de la categoría
      final compraAModificar = categoriaModificada.purchases.firstWhere(
        (compra) => compra.id == event.idPurchase,
      );
      if (event.modificationType == ModificationType.increase) {
        updatePurchase(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: categoriaModificada.id,
          newPurchase: compraAModificar
            ..amountOfQuotas += 1
            ..current = true,
        );
      } else {
        if (compraAModificar.amountOfQuotas > 1) {
          updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: categoriaModificada.id,
            newPurchase: compraAModificar..amountOfQuotas -= 1,
          );
        } else {
          updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: categoriaModificada.id,
            newPurchase: compraAModificar
              ..current = false
              ..amountOfQuotas -= 1
              ..lastCuotaDate = DateTime.now(),
          );
        }
      }
      emit(
        state.copyWith(
          estado: Status.success,
          listaCategorias: listaCategorias,
        ),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onCreateFinancialEntity(
    BlocDashboardEventCreateFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await createFinancialEntity(
        financialEntityName: event.financialEntityName,
        idUser: auth.currentUser?.uid ?? '',
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocDashboardEventDeleteFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await deleteCategoria(
        categoriaId: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onCreatePurchase(
    BlocDashboardEventCreatePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      final nuevaCompra = Purchase(
        creationDate: DateTime.now(),
        debt: event.debtOrDebtor,
        id: DateTime.now().toString(),
        amountOfQuotas: event.amountQuotas,
        totalAmount: event.totalAmount,
        amountPerQuota: event.totalAmount / event.amountQuotas,
        nameOfProduct: event.productName,
        current: event.current,
      );
      await createCompra(
        usuarioId: auth.currentUser?.uid ?? '',
        categoriaId: event.idFinancialEntity,
        nuevaCompra: nuevaCompra,
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onEditPurchase(
    BlocDashboardEventEditPurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;

      final nuevaCompra = event.purchase
        ..amountOfQuotas = event.amountOfQuotas
        ..totalAmount = event.amount
        ..nameOfProduct = event.productName
        ..debt = event.debtOrDebtor
        ..amountPerQuota = event.amount / event.amountOfQuotas;

      await updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: event.idFinancialEntity,
        newPurchase: nuevaCompra,
      );

      add(BlocDashboardEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }

  Future<void> _onDeletePurchase(
    BlocDashboardEventDeletePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await deleteCompra(
        categoriaId: event.idFinancialEntity,
        usuarioId: auth.currentUser?.uid ?? '',
        compraId: event.idPurchase,
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: e.toString(), estado: Status.error));
    }
  }
}
