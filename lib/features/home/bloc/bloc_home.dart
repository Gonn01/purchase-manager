import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/enums/status.dart';
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
  BlocHome() : super(const BlocHomeState()) {
    on<BlocHomeEventInitialize>(_onInitialize);
    on<BlocHomeEventModifyAmountOfQuotas>(_onModifyAmountOfQuotas);
    on<BlocHomeEventCreateFinancialEntity>(_onCreateFinancialEntity);
    on<BlocHomeEventDeleteFinancialEntity>(_onDeleteFinancialEntity);
    on<BlocHomeEventCreatePurchase>(_onCreatePurchase);
    on<BlocHomeEventEditPurchase>(_onEditPurchase);
    on<BlocHomeEventDeletePurchase>(_onDeletePurchase);

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
    emit(state.copyWith(estado: Status.loading));
    try {
      final listFinancialeEntity = await _firebaseService.readFinancialEntities(
        idUser: auth.currentUser?.uid ?? '',
      );

      final dolar = await DolarService().getDollarData();

      emit(
        state.copyWith(
          coin: dolar,
          estado: Status.success,
          financialEntityList: listFinancialeEntity,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onModifyAmountOfQuotas(
    BlocHomeEventModifyAmountOfQuotas event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      state.copyWith(
        estado: Status.initial,
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
      );

      if (event.modificationType == ModificationType.increase) {
        final newLog = 'Se agregó una cuota.${DateTime.now().formatWithHour}';
        purchaseToModify
          ..amountOfQuotas += 1
          ..type = event.purchaseType.isCurrent
              ? event.purchaseType
              : event.purchaseType == PurchaseType.settledDebtorPurchase
                  ? PurchaseType.currentDebtorPurchase
                  : PurchaseType.currentCreditorPurchase
          ..logs.add(newLog);

        unawaited(
          _firebaseService.updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: financialEntityModified.id,
            newPurchase: purchaseToModify,
          ),
        );
      } else {
        if (purchaseToModify.amountOfQuotas > 1) {
          purchaseToModify
            ..amountOfQuotas -= 1
            ..logs.add(
              'Se bajo una cuota.${DateTime.now().formatWithHour}',
            );

          unawaited(
            _firebaseService.updatePurchase(
              idUser: auth.currentUser?.uid ?? '',
              idFinancialEntity: financialEntityModified.id,
              newPurchase: purchaseToModify,
            ),
          );
        } else {
          purchaseToModify
            ..type = event.purchaseType == PurchaseType.currentDebtorPurchase
                ? PurchaseType.settledDebtorPurchase
                : PurchaseType.settledCreditorPurchase
            ..amountOfQuotas -= 1
            ..lastCuotaDate = DateTime.now()
            ..logs.add(
              'Se pago la ultima cuota. ${DateTime.now().formatWithHour}',
            );

          unawaited(
            _firebaseService.updatePurchase(
              idUser: auth.currentUser?.uid ?? '',
              idFinancialEntity: financialEntityModified.id,
              newPurchase: purchaseToModify,
            ),
          );
        }
      }
      final index = listFinancialEntity.indexOf(financialEntityModified);

      listFinancialEntity[index] = financialEntityModified;

      emit(
        state.copyWith(
          estado: Status.success,
          financialEntityList: listFinancialEntity,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onCreateFinancialEntity(
    BlocHomeEventCreateFinancialEntity event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      await _firebaseService.createFinancialEntity(
        financialEntityName: event.financialEntityName,
        idUser: auth.currentUser?.uid ?? '',
      );

      add(BlocHomeEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocHomeEventDeleteFinancialEntity event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      await _firebaseService.deleteFinancialEntity(
        idFinancialEntity: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onCreatePurchase(
    BlocHomeEventCreatePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final nuevaCompra = Purchase(
        creationDate: DateTime.now(),
        id: DateTime.now().toString(),
        amountOfQuotas: event.amountQuotas,
        totalAmount: event.totalAmount,
        amountPerQuota: event.totalAmount / event.amountQuotas,
        nameOfProduct: event.productName,
        type: event.purchaseType,
        currency: event.currency,
        logs: ['Se creó la compra. ${DateTime.now().formatWithHour}'],
      );

      unawaited(
        _firebaseService.createPurchase(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: event.financialEntity.id,
          newPurchase: nuevaCompra,
        ),
      );
      final financialEntityModified = state.financialEntityList.firstWhere(
        (financialEntity) => financialEntity.id == event.financialEntity.id,
      );
      final newList = List<FinancialEntity>.from(state.financialEntityList)
        ..removeWhere((element) => element.id == event.financialEntity.id)
        ..add(
          FinancialEntity(
            id: event.financialEntity.id,
            name: event.financialEntity.name,
            purchases: financialEntityModified.purchases..add(nuevaCompra),
            logs: financialEntityModified.logs
              ..add('Se creó la compra ${event.productName}. '
                  '${DateTime.now().formatWithHour}'),
          ),
        );
      emit(
        state.copyWith(
          estado: Status.success,
          financialEntityList: newList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onEditPurchase(
    BlocHomeEventEditPurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final nuevaCompra = event.purchase
        ..amountOfQuotas = event.amountOfQuotas
        ..totalAmount = event.amount
        ..nameOfProduct = event.productName
        ..type = event.purchaseType
        ..amountPerQuota = event.amount / event.amountOfQuotas
        ..currency = event.currency
        ..logs.add('Se editó la compra. ${DateTime.now().formatWithHour}');

      unawaited(
        _firebaseService.updatePurchase(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: event.idFinancialEntity,
          newPurchase: nuevaCompra,
        ),
      );
      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final financialEntityModified = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.purchase.id),
      );

      financialEntityModified.purchases
        ..removeWhere((element) => element.id == event.purchase.id)
        ..add(nuevaCompra);

      final index = listFinancialEntity.indexOf(financialEntityModified);

      listFinancialEntity[index] = financialEntityModified;

      emit(
        state.copyWith(
          estado: Status.success,
          financialEntityList: listFinancialEntity,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeletePurchase(
    BlocHomeEventDeletePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    try {
      unawaited(
        _firebaseService.deletePurchase(
          idFinancialEntity: event.idFinancialEntity,
          idUser: auth.currentUser?.uid ?? '',
          idPurchase: event.purchase.id,
        ),
      );

      final list = List<FinancialEntity>.from(state.financialEntityList);

      final financialEntityModified = list.firstWhere(
        (financialEntity) => financialEntity.id == event.idFinancialEntity,
      );

      final newList = List<FinancialEntity>.from(state.financialEntityList)
        ..removeWhere(
          (financialEntity) => financialEntity.id == financialEntityModified.id,
        )
        ..add(
          FinancialEntity(
            id: financialEntityModified.id,
            name: financialEntityModified.name,
            purchases: financialEntityModified.purchases
              ..removeWhere((purchase) => purchase.id == event.purchase.id),
            logs: financialEntityModified.logs
              ..add('Se eliminó la compra ${event.purchase.nameOfProduct}. '
                  '${DateTime.now().formatWithHour}'),
          ),
        );

      emit(
        state.copyWith(
          estado: Status.success,
          financialEntityList: newList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }
}
