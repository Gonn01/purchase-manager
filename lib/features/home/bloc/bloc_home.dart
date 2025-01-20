import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/services/dolar.dart';
import 'package:purchase_manager/utilities/services/firebase_service.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocHome extends Bloc<BlocHomeEvento, BlocHomeState> {
  /// {@macro BlocInicio}
  BlocHome() : super(BlocHomeStateInitial()) {
    on<BlocHomeEventInitialize>(_onInitialize);
    on<BlocHomeEventIncreaseAmountOfQuotas>(_onIncreaseAmountOfQuotas);
    on<BlocHomeEventPayQuota>(_onPayQuota);
    on<BlocHomeEventCreateFinancialEntity>(_onCreateFinancialEntity);
    on<BlocHomeEventDeleteFinancialEntity>(_onDeleteFinancialEntity);
    on<BlocHomeEventCreatePurchase>(_onCreatePurchase);
    on<BlocHomeEventEditPurchase>(_onEditPurchase);
    on<BlocHomeEventDeletePurchase>(_onDeletePurchase);
    on<BlocHomeEventPayMonth>(_onPayMonth);

    add(BlocHomeEventInitialize());
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  final _firebaseService = FirebaseService();

  Future<void> _onInitialize(
    BlocHomeEventInitialize event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      await _firebaseService.crearValorCuotasPagadas();
      await _firebaseService.actualizarFechaCreacionComoString();
      final listFinancialeEntity = await _firebaseService.readFinancialEntities(
        idUser: auth.currentUser?.uid ?? '',
      );

      final dolar = await DolarService().getDollarData();

      emit(
        BlocHomeStateSuccess.from(
          state,
          currency: dolar,
          financialEntityList: listFinancialeEntity,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onIncreaseAmountOfQuotas(
    BlocHomeEventIncreaseAmountOfQuotas event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      BlocHomeStateLoadingPurchase.from(
        state,
        purchaseLoadingId: event.idPurchase,
      ),
    );

    try {
      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final financialEntityModified = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.idPurchase),
      );

      final purchaseToModify = financialEntityModified.purchases.firstWhere(
        (compra) => compra.id == event.idPurchase,
      )
        ..quotasPayed -= 1
        ..type = event.purchaseType.isCurrent
            ? event.purchaseType
            : event.purchaseType == PurchaseType.settledDebtorPurchase
                ? PurchaseType.currentDebtorPurchase
                : PurchaseType.currentCreditorPurchase
        ..logs.add('Se agregó una cuota.${DateTime.now().formatWithHour}');

      await _firebaseService.updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: financialEntityModified.id,
        newPurchase: purchaseToModify,
      );

      final index = listFinancialEntity.indexOf(financialEntityModified);

      listFinancialEntity[index] = financialEntityModified;

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onPayQuota(
    BlocHomeEventPayQuota event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      BlocHomeStateLoadingPurchase.from(
        state,
        purchaseLoadingId: event.idPurchase,
      ),
    );
    try {
      final listFinancialEntity = await payQuota(
        idPurchase: event.idPurchase,
        purchaseType: event.purchaseType,
      );

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onCreateFinancialEntity(
    BlocHomeEventCreateFinancialEntity event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      await _firebaseService.createFinancialEntity(
        financialEntityName: event.financialEntityName,
        idUser: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..add(
          FinancialEntity(
            id: '',
            name: event.financialEntityName,
            purchases: [],
            logs: ['Se creó la categoría. ${DateTime.now().formatWithHour}'],
          ),
        );

      emit(BlocHomeStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocHomeEventDeleteFinancialEntity event,
    Emitter<BlocHomeState> emit,
  ) async {
    try {
      await _firebaseService.deleteFinancialEntity(
        idFinancialEntity: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..removeWhere(
          (financialEntity) => financialEntity.id == event.idFinancialEntity,
        );

      emit(BlocHomeStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onCreatePurchase(
    BlocHomeEventCreatePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    try {
      final nuevaCompra = Purchase(
        creationDate: DateTime.now().formatWithHour,
        amountOfQuotas: event.amountQuotas,
        quotasPayed: 0,
        totalAmount: event.totalAmount,
        amountPerQuota: event.totalAmount / event.amountQuotas,
        nameOfProduct: event.productName,
        type: event.purchaseType,
        currency: event.currency,
        logs: ['Se creó la compra. ${DateTime.now().formatWithHour}'],
      );

      final newPurchaseId = await _firebaseService.createPurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: event.financialEntity.id,
        newPurchase: nuevaCompra,
      );

      final newList = List<FinancialEntity>.from(state.financialEntityList);

      final index = newList.indexWhere(
        (financialEntity) => financialEntity.id == event.financialEntity.id,
      );

      final updatedEntity = newList[index].copyWith(
        purchases: [
          ...newList[index].purchases,
          nuevaCompra..id = newPurchaseId,
        ],
        logs: [
          ...newList[index].logs,
          '''Se creó la compra ${event.productName}. ${DateTime.now().formatWithHour}''',
        ],
      );

      newList[index] = updatedEntity;
      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onEditPurchase(
    BlocHomeEventEditPurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      BlocHomeStateLoadingPurchase.from(
        state,
        purchaseLoadingId: event.purchase.id,
      ),
    );
    try {
      final nuevaCompra = event.purchase
        ..amountOfQuotas = event.amountOfQuotas
        ..totalAmount = event.amount
        ..nameOfProduct = event.productName
        ..type = event.purchaseType
        ..amountPerQuota = event.amount / event.amountOfQuotas
        ..currency = event.currency
        ..logs.add('Se editó la compra. ${DateTime.now().formatWithHour}');

      await _firebaseService.updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: event.idFinancialEntity,
        newPurchase: nuevaCompra,
      );

      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final index = listFinancialEntity.indexWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.purchase.id),
      );

      if (index != -1) {
        final updatedEntity = listFinancialEntity[index].copyWith(
          purchases: [
            ...listFinancialEntity[index].purchases.map((compra) {
              return compra.id == event.purchase.id ? nuevaCompra : compra;
            }),
          ],
        );

        listFinancialEntity[index] = updatedEntity;
      }
      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onDeletePurchase(
    BlocHomeEventDeletePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      BlocHomeStateLoadingPurchase.from(
        state,
        purchaseLoadingId: event.purchase.id,
      ),
    );
    try {
      await _firebaseService.deletePurchase(
        idFinancialEntity: event.idFinancialEntity,
        idUser: auth.currentUser?.uid ?? '',
        idPurchase: event.purchase.id ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList);

      final index = list.indexWhere(
        (financialEntity) => financialEntity.id == event.idFinancialEntity,
      );

      final log = 'Se eliminó la compra ${event.purchase.nameOfProduct}. '
          '${DateTime.now().formatWithHour}';

      final updatedEntity = list[index].copyWith(
        purchases: [
          ...list[index]
              .purchases
              .where((purchase) => purchase.id != event.purchase.id),
        ],
        logs: [
          ...list[index].logs,
          log,
        ],
      );

      list[index] = updatedEntity;

      emit(BlocHomeStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onPayMonth(
    BlocHomeEventPayMonth event,
    Emitter<BlocHomeState> emit,
  ) async {
    try {
      for (final purchase in event.purchaseList) {
        emit(
          BlocHomeStateLoadingPurchase.from(
            state,
            purchaseLoadingId: purchase.id,
          ),
        );
        await payQuota(
          idPurchase: purchase.id ?? '',
          purchaseType: purchase.type,
        );
        emit(
          BlocHomeStateSuccess.from(
            state,
            deleteSelectedShipmentId: true,
          ),
        );
      }
    } on Exception catch (e) {
      emit(BlocHomeStateError.from(state, error: e.toString()));
    }
  }

  /// Paga una cuota de una compra
  Future<List<FinancialEntity>> payQuota({
    required String idPurchase,
    required PurchaseType purchaseType,
  }) async {
    final listFinancialEntity =
        List<FinancialEntity>.from(state.financialEntityList);

    final financialEntityModified = listFinancialEntity.firstWhere(
      (financialEntity) =>
          financialEntity.purchases.any((compra) => compra.id == idPurchase),
    );

    final purchaseToModify = financialEntityModified.purchases.firstWhere(
      (compra) => compra.id == idPurchase,
    );

    if (purchaseToModify.quotasPayed < purchaseToModify.amountOfQuotas &&
        (purchaseToModify.amountOfQuotas - 1) != purchaseToModify.quotasPayed) {
      purchaseToModify
        ..quotasPayed += 1
        ..logs.add(
          'Se pago una cuota.${DateTime.now().formatWithHour}',
        );
      if (purchaseToModify.quotasPayed == 1) {
        purchaseToModify.firstQuotaDate = DateTime.now().formatWithHour;
      }
      await _firebaseService.updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: financialEntityModified.id,
        newPurchase: purchaseToModify,
      );
    } else {
      purchaseToModify
        ..type = purchaseType == PurchaseType.currentDebtorPurchase
            ? PurchaseType.settledDebtorPurchase
            : PurchaseType.settledCreditorPurchase
        ..quotasPayed += 1
        ..lastQuotaDate = DateTime.now().formatWithHour
        ..logs.add(
          'Se pago la ultima cuota. ${DateTime.now().formatWithHour}',
        );

      await _firebaseService.updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: financialEntityModified.id,
        newPurchase: purchaseToModify,
      );
    }

    final index = listFinancialEntity.indexOf(financialEntityModified);

    listFinancialEntity[index] = financialEntityModified;
    return listFinancialEntity;
  }
}
