import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchase_manager/endpoints/crud_financial_entity.dart';
import 'package:purchase_manager/endpoints/crud_purchase.dart';
import 'package:purchase_manager/endpoints/services/dolar.dart';
import 'package:purchase_manager/extensions/date_time.dart';
import 'package:purchase_manager/models/currency.dart';
import 'package:purchase_manager/models/enums/currency_type.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

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

  Future<void> _onInitialize(
    BlocHomeEventInitialize event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      final listFinancialeEntity =
          await readFinancialEntities(idUser: auth.currentUser?.uid ?? '');
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
    try {
      final auth = FirebaseAuth.instance;

      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final financialEntityModified = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.idPurchase),
      );

      final compraAModificar = financialEntityModified.purchases.firstWhere(
        (compra) => compra.id == event.idPurchase,
      );

      if (event.modificationType == ModificationType.increase) {
        await Future.wait([
          updatePurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: financialEntityModified.id,
            newPurchase: compraAModificar
              ..amountOfQuotas += 1
              ..type = event.purchaseType.isCurrent
                  ? event.purchaseType
                  : event.purchaseType == PurchaseType.settledDebtorPurchase
                      ? PurchaseType.currentDebtorPurchase
                      : PurchaseType.currentCreditorPurchase,
          ),
          updatePurchaseLogs(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: financialEntityModified.id,
            idPurchase: compraAModificar.id,
            newLog: 'Se agregó una cuota.${DateTime.now().formatWithHour}',
          ),
        ]);
      } else {
        if (compraAModificar.amountOfQuotas > 1) {
          await Future.wait(
            [
              updatePurchase(
                idUser: auth.currentUser?.uid ?? '',
                idFinancialEntity: financialEntityModified.id,
                newPurchase: compraAModificar..amountOfQuotas -= 1,
              ),
              updatePurchaseLogs(
                idUser: auth.currentUser?.uid ?? '',
                idFinancialEntity: financialEntityModified.id,
                idPurchase: compraAModificar.id,
                newLog: 'Se bajo una cuota.${DateTime.now().formatWithHour}',
              ),
            ],
          );
        } else {
          await Future.wait(
            [
              updatePurchase(
                idUser: auth.currentUser?.uid ?? '',
                idFinancialEntity: financialEntityModified.id,
                newPurchase: compraAModificar
                  ..type =
                      event.purchaseType == PurchaseType.currentDebtorPurchase
                          ? PurchaseType.settledDebtorPurchase
                          : PurchaseType.settledCreditorPurchase
                  ..amountOfQuotas -= 1
                  ..lastCuotaDate = DateTime.now(),
              ),
              updatePurchaseLogs(
                idUser: auth.currentUser?.uid ?? '',
                idFinancialEntity: financialEntityModified.id,
                idPurchase: compraAModificar.id,
                newLog:
                    'Se pago la ultima cuota. ${DateTime.now().formatWithHour}',
              ),
            ],
          );
        }
      }
      add(BlocHomeEventInitialize());
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
      final auth = FirebaseAuth.instance;

      await createFinancialEntity(
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
      final auth = FirebaseAuth.instance;

      await deleteFinancialEntity(
        idFinancialEntity: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );

      add(BlocHomeEventInitialize());

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
        logs: ['Se creó la compra. ${DateTime.now().formatWithHour}'],
      );

      await Future.wait(
        [
          createPurchase(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: event.idFinancialEntity,
            newPurchase: nuevaCompra,
          ),
          updateFinancialEntityLogs(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: event.idFinancialEntity,
            newLog: 'Se creo una compra ${event.productName} '
                '${DateTime.now().formatWithHour}',
          ),
        ],
      );

      add(BlocHomeEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
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
      final auth = FirebaseAuth.instance;

      final nuevaCompra = event.purchase
        ..amountOfQuotas = event.amountOfQuotas
        ..totalAmount = event.amount
        ..nameOfProduct = event.productName
        ..type = event.purchaseType
        ..amountPerQuota = event.amount / event.amountOfQuotas
        ..currency = event.currency;

      await Future.wait([
        updatePurchase(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: event.idFinancialEntity,
          newPurchase: nuevaCompra,
        ),
        updatePurchaseLogs(
          idUser: auth.currentUser?.uid ?? '',
          idFinancialEntity: event.idFinancialEntity,
          idPurchase: nuevaCompra.id,
          newLog: 'Se edito la compra ${DateTime.now().formatWithHour}',
        ),
      ]);

      add(BlocHomeEventInitialize());

      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }

  Future<void> _onDeletePurchase(
    BlocHomeEventDeletePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final auth = FirebaseAuth.instance;
      await Future.wait(
        [
          deletePurchase(
            idFinancialEntity: event.idFinancialEntity,
            idUser: auth.currentUser?.uid ?? '',
            idPurchase: event.purchase.id,
          ),
          updateFinancialEntityLogs(
            idUser: auth.currentUser?.uid ?? '',
            idFinancialEntity: event.idFinancialEntity,
            newLog: 'Se eliminó la compra ${event.purchase.nameOfProduct} '
                'en la entidad ${DateTime.now().formatWithHour}',
          ),
        ],
      );
      add(BlocHomeEventInitialize());
      emit(
        state.copyWith(estado: Status.success),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }
}
