import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/endpoints/crud_financial_entity.dart';
import 'package:purchase_manager/endpoints/crud_purchase.dart';
import 'package:purchase_manager/endpoints/services/dolar.dart';
import 'package:purchase_manager/models/currency.dart';
import 'package:purchase_manager/models/enums/currency_type.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

part 'bloc_dashboard_event.dart';
part 'bloc_dashboard_state.dart';

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
      final dolar = await DolarService().getDollarData();
      emit(
        state.copyWith(
          coin: dolar,
          estado: Status.success,
          listaCategorias: listaCategorias,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
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

      final categoriaModificada = listaCategorias.firstWhere(
        (categoria) =>
            categoria.purchases.any((compra) => compra.id == event.idPurchase),
      );

      final compraAModificar = categoriaModificada.purchases.firstWhere(
        (compra) => compra.id == event.idPurchase,
      );

      if (event.modificationType == ModificationType.increase) {
        await updatePurchase(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: categoriaModificada.id,
          newPurchase: compraAModificar
            ..amountOfQuotas += 1
            ..type = event.purchaseType.isCurrent
                ? event.purchaseType
                : event.purchaseType == PurchaseType.settledDebtorPurchase
                    ? PurchaseType.currentDebtorPurchase
                    : PurchaseType.currentCreditorPurchase,
        );
      } else {
        if (compraAModificar.amountOfQuotas > 1) {
          await updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: categoriaModificada.id,
            newPurchase: compraAModificar..amountOfQuotas -= 1,
          );
        } else {
          await updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: categoriaModificada.id,
            newPurchase: compraAModificar
              ..type = event.purchaseType == PurchaseType.currentDebtorPurchase
                  ? PurchaseType.settledDebtorPurchase
                  : PurchaseType.settledCreditorPurchase
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
      emit(state.copyWith(estado: Status.error));
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
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocDashboardEventDeleteFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await deleteFinancialEntity(
        categoriaId: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
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
        id: DateTime.now().toString(),
        amountOfQuotas: event.amountQuotas,
        totalAmount: event.totalAmount,
        amountPerQuota: event.totalAmount / event.amountQuotas,
        nameOfProduct: event.productName,
        type: event.purchaseType,
        currency: event.currency,
      );

      await createPurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: event.idFinancialEntity,
        newPurchase: nuevaCompra,
      );

      add(BlocDashboardEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
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
        ..type = event.purchaseType
        ..amountPerQuota = event.amount / event.amountOfQuotas
        ..currency = event.currency;

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
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeletePurchase(
    BlocDashboardEventDeletePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await deletePurchase(
        idFinancialEntity: event.idFinancialEntity,
        idUser: auth.currentUser?.uid ?? '',
        idPurchase: event.idPurchase,
      );
      add(BlocDashboardEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }
}
