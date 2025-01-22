import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/services/dolar.dart';
import 'package:purchase_manager/utilities/services/firebase_service.dart';

part 'bloc_dashboard_event.dart';
part 'bloc_dashboard_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvent, BlocDashboardState> {
  /// {@macro BlocInicio}
  BlocDashboard() : super(BlocDashboardStateInitial()) {
    on<BlocDashboardEventInitialize>(_onInitialize);
    on<BlocDashboardEventIncreaseAmountOfQuotas>(_onIncreaseAmountOfQuotas);
    on<BlocDashboardEventPayQuota>(_onPayQuota);
    on<BlocDashboardEventCreateFinancialEntity>(_onCreateFinancialEntity);
    on<BlocDashboardEventDeleteFinancialEntity>(_onDeleteFinancialEntity);
    on<BlocDashboardEventCreatePurchase>(_onCreatePurchase);
    on<BlocDashboardEventEditPurchase>(_onEditPurchase);
    on<BlocDashboardEventDeletePurchase>(_onDeletePurchase);
    on<BlocDashboardEventPayMonth>(_onPayMonth);
    on<BlocDashboardEventAlternateIgnorePurchase>(_onAlternateIgnorePurchase);
    on<BlocDashboardEventAddImage>(_onAddImage);
    on<BlocDashboardEventDeleteImageAt>(_onDeleteImageAt);
    on<BlocDashboardEventSignOut>(_onSignOut);
    on<BlocDashboardEventSelectFinancialEntity>(
      _onSelectFinancialEntity,
    );

    add(BlocDashboardEventInitialize());
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  final _firebaseService = FirebaseService();

  Future<void> _onSignOut(
    BlocDashboardEventSignOut event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      await auth.signOut();
      emit(BlocDashboardStateSuccessSignOut.from(state));
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onInitialize(
    BlocDashboardEventInitialize event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      await _firebaseService.crearValorCuotasPagadasYIgnored();
      await _firebaseService.actualizarFechaCreacionComoString();
      final listFinancialeEntity = await _firebaseService.readFinancialEntities(
        idUser: auth.currentUser?.uid ?? '',
      );

      final dolar = await DolarService().getDollarData();

      emit(
        BlocDashboardStateSuccess.from(
          state,
          currency: dolar,
          financialEntityList: listFinancialeEntity,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onIncreaseAmountOfQuotas(
    BlocDashboardEventIncreaseAmountOfQuotas event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(
      BlocDashboardStateLoadingPurchase.from(
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
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onPayQuota(
    BlocDashboardEventPayQuota event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(
      BlocDashboardStateLoadingPurchase.from(
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
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onCreateFinancialEntity(
    BlocDashboardEventCreateFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      final newFinancialEntity = await _firebaseService.createFinancialEntity(
        financialEntityName: event.financialEntityName,
        idUser: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..add(
          newFinancialEntity,
        );

      emit(BlocDashboardStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onDeleteFinancialEntity(
    BlocDashboardEventDeleteFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(BlocDashboardStateLoading.from(state));
    try {
      await _firebaseService.deleteFinancialEntity(
        idFinancialEntity: event.idFinancialEntity,
        idUsuario: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..removeWhere(
          (financialEntity) => financialEntity.id == event.idFinancialEntity,
        );

      emit(BlocDashboardStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onCreatePurchase(
    BlocDashboardEventCreatePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    try {
      String? url;

      if (state.images.isNotEmpty) {
        url = await uploadImage(state.images.first);
      }

      final nuevaCompra = Purchase(
        creationDate: DateTime.now().formatWithHour,
        amountOfQuotas: event.amountQuotas,
        totalAmount: event.totalAmount,
        amountPerQuota: event.totalAmount / event.amountQuotas,
        nameOfProduct: event.productName,
        type: event.purchaseType,
        currency: event.currency,
        logs: ['Se creó la compra. ${DateTime.now().formatWithHour}'],
        image: url,
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
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: newList,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onEditPurchase(
    BlocDashboardEventEditPurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(
      BlocDashboardStateLoadingPurchase.from(
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
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onDeletePurchase(
    BlocDashboardEventDeletePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(
      BlocDashboardStateLoadingPurchase.from(
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

      emit(BlocDashboardStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  Future<void> _onPayMonth(
    BlocDashboardEventPayMonth event,
    Emitter<BlocDashboardState> emit,
  ) async {
    try {
      for (final purchase in event.purchaseList) {
        emit(
          BlocDashboardStateLoadingPurchase.from(
            state,
            purchaseLoadingId: purchase.id,
          ),
        );
        await payQuota(
          idPurchase: purchase.id ?? '',
          purchaseType: purchase.type,
        );
        emit(
          BlocDashboardStateSuccess.from(
            state,
            deleteSelectedShipmentId: true,
          ),
        );
      }
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
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

  Future<void> _onAlternateIgnorePurchase(
    BlocDashboardEventAlternateIgnorePurchase event,
    Emitter<BlocDashboardState> emit,
  ) async {
    emit(
      BlocDashboardStateLoadingPurchase.from(
        state,
        purchaseLoadingId: event.purchaseId,
      ),
    );
    try {
      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final financialEntityModified = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.purchaseId),
      );

      final purchaseToModify = financialEntityModified.purchases.firstWhere(
        (compra) => compra.id == event.purchaseId,
      );

      purchaseToModify.ignored = !purchaseToModify.ignored;

      await _firebaseService.updatePurchase(
        idUser: auth.currentUser?.uid ?? '',
        idFinancialEntity: financialEntityModified.id,
        newPurchase: purchaseToModify,
      );

      final index = listFinancialEntity.indexOf(financialEntityModified);

      listFinancialEntity[index] = financialEntityModified;

      emit(
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(BlocDashboardStateError.from(state, error: e.toString()));
    }
  }

  void _onAddImage(
    BlocDashboardEventAddImage event,
    Emitter<BlocDashboardState> emit,
  ) {
    final images = List<XFile>.from(state.images)..add(event.image);

    emit(BlocDashboardStateSuccess.from(state, images: images));
  }

  void _onDeleteImageAt(
    BlocDashboardEventDeleteImageAt event,
    Emitter<BlocDashboardState> emit,
  ) {
    final images = List<XFile>.from(state.images)..removeAt(event.index);

    emit(BlocDashboardStateSuccess.from(state, images: images));
  }

  void _onSelectFinancialEntity(
    BlocDashboardEventSelectFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) {
    add(BlocDashboardEventInitialize());
    emit(
      BlocDashboardStateSuccess.from(
        state,
        financialEntitySelected: event.financialEntity,
      ),
    );
  }
}

///
Future<String> uploadImage(XFile image) async {
  final url =
      Uri.parse('https://api.cloudinary.com/v1_1/dkdwnhsxf/image/upload');

  try {
    // Crea un multipart request
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] =
          'purchasemanager' // Asegúrate de usar el nombre correcto del preset
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    // Envía la solicitud
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final responses = jsonDecode(responseData);

      // ignore: avoid_dynamic_calls asd
      final nombre = responses['url'] as String;
      return nombre;
    } else {
      throw Exception('Error al subir la imagen: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Excepción al subir la imagen: $e');
  }
}
