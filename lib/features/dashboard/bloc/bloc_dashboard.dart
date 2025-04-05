import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:purchase_manager/features/dashboard/repositories/dashboard_repository.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/features/dashboard/repositories/purchases_repository.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/logs.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/services/currency_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bloc_dashboard_event.dart';
part 'bloc_dashboard_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvent, BlocDashboardState> {
  /// {@macro BlocInicio}
  BlocDashboard() : super(BlocDashboardStateInitial()) {
    on<BlocDashboardEventSignOut>(_onSignOut);
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
    on<BlocDashboardEventSelectFinancialEntity>(
      _onSelectFinancialEntity,
    );
    on<BlocDashboardEventSelectCurrency>(
      _onSelectCurrency,
    );

    add(BlocDashboardEventInitialize());
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  // final _firebaseService = FirebaseService();
  final _dashboardRepository = DashboardRepository();

  final _purchasesRepository = PurchasesRepository();

  final _financialEntitiesRepository = FinancialEntitiesRepository();
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
      final responseListFinancialeEntity =
          await _dashboardRepository.getDashboardData();

      final preferences = await SharedPreferences.getInstance();

      final currencyTypeValue = preferences.getInt('currency');

      final currencyTypeSelected = CurrencyType.type(currencyTypeValue ?? 0);

      final dolar = await DolarService().getDollarData();

      emit(
        BlocDashboardStateSuccess.from(
          state,
          currency: dolar,
          financialEntityList: responseListFinancialeEntity.body,
          selectedCurrency: currencyTypeSelected,
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
        purchaseLoadingId: event.purchaseId,
      ),
    );

    try {
      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final modifiedFinancialEntity = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.purchaseId),
      );

      final purchaseToModify = modifiedFinancialEntity.purchases.firstWhere(
        (compra) => compra.id == event.purchaseId,
      );

      final modifiedPurchaseResponse = await _purchasesRepository.unpayQuota(
        purchaseId: purchaseToModify.id,
      );

      final modifiedPurchase = modifiedPurchaseResponse.body;

      final updatedFinancialEntity = modifiedFinancialEntity.copyWith(
        purchases: [
          ...modifiedFinancialEntity.purchases.map(
            (compra) =>
                compra.id == event.purchaseId ? modifiedPurchase : compra,
          ),
        ],
      );

      final newList = List<FinancialEntity>.from(
        listFinancialEntity.map(
          (financialEntity) => financialEntity.id == updatedFinancialEntity.id
              ? updatedFinancialEntity
              : financialEntity,
        ),
      );

      emit(
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: newList,
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
      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final modifiedFinancialEntity = listFinancialEntity.firstWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.idPurchase),
      );

      final purchaseToModify = modifiedFinancialEntity.purchases.firstWhere(
        (compra) => compra.id == event.idPurchase,
      );

      final modifiedPurchaseResponse = await _purchasesRepository.payQuota(
        purchaseId: purchaseToModify.id,
      );

      final modifiedPurchase = modifiedPurchaseResponse.body;

      final updatedFinancialEntity = modifiedFinancialEntity.copyWith(
        purchases: [
          ...modifiedFinancialEntity.purchases.map(
            (compra) =>
                compra.id == event.idPurchase ? modifiedPurchase : compra,
          ),
        ],
      );

      final newList = List<FinancialEntity>.from(
        listFinancialEntity.map(
          (financialEntity) => financialEntity.id == updatedFinancialEntity.id
              ? updatedFinancialEntity
              : financialEntity,
        ),
      );

      emit(
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: newList,
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
      final newFinancialEntityResponse =
          await _financialEntitiesRepository.createFinancialEntity(
        financialEntityName: event.financialEntityName,
        firebaseUserId: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..add(
          newFinancialEntityResponse.body,
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
      await _financialEntitiesRepository.deleteFinancialEntity(
        financialEntityId: event.idFinancialEntity,
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
        url = await uploadImage(state.images.first, event.productName);
      }

      final newPurchaseId = await _purchasesRepository.createPurchase(
        amount: event.totalAmount,
        amountPerQuota: event.isFixedExpenses
            ? event.totalAmount
            : event.amountQuotas == 0
                ? 0
                : event.totalAmount / event.amountQuotas,
        currencyType: event.currency,
        fixedExpense: event.isFixedExpenses,
        image: url,
        purchaseName: event.productName,
        payedQuotas: event.payedQuotas,
        purchaseType: event.purchaseType,
        financialEntityId: event.financialEntity.id,
        ignored: event.ignored,
        numberOfQuotas: event.amountQuotas,
      );

      final newList = List<FinancialEntity>.from(state.financialEntityList);

      final index = newList.indexWhere(
        (financialEntity) => financialEntity.id == event.financialEntity.id,
      );

      final updatedEntity = newList[index].copyWith(
        purchases: [
          ...newList[index].purchases,
          newPurchaseId.body,
        ],
      );

      newList[index] = updatedEntity;

      emit(
        BlocDashboardStateSuccess.from(
          state,
          financialEntityList: newList,
          deleteImage: true,
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
      if (state.images.isNotEmpty) {
        await deleteImage(
          'public/purchase-manager/${event.purchase.name}',
        );
        await uploadImage(
          state.images.first,
          event.name,
        );
      }

      final modifiedPurchaseResponse = await _purchasesRepository.editPurchase(
        amount: event.amount,
        numberOfQuotas: event.amountOfQuotas,
        currencyType: event.currency,
        fixedExpense: event.isFixedExpenses,
        payedQuotas: event.payedQuotas,
        purchaseId: event.purchase.id,
        purchaseName: event.name,
        purchaseType: event.purchaseType,
        financialEntityId: event.idFinancialEntity,
        ignored: event.ignored,
        image: event.image,
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
              return compra.id == event.purchase.id
                  ? modifiedPurchaseResponse.body
                  : compra;
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
          deleteImage: true,
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
      await _purchasesRepository.deletePurchase(
        purchaseId: event.purchase.id,
      );

      final list = List<FinancialEntity>.from(state.financialEntityList);

      final index = list.indexWhere(
        (financialEntity) => financialEntity.id == event.idFinancialEntity,
      );

      final updatedEntity = list[index].copyWith(
        purchases: [
          ...list[index]
              .purchases
              .where((purchase) => purchase.id != event.purchase.id),
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
      final purchaseIds = event.purchaseList.map((e) => e.id).toList();
      emit(
        BlocDashboardStateLoadingPurchase.from(
          state,
          purchasesLoadingsIds: purchaseIds,
        ),
      );

      final modifiedPurchasesResponse = await _purchasesRepository.payMonth(
        purchaseIds: purchaseIds,
      );

      final listFinancialEntity =
          List<FinancialEntity>.from(state.financialEntityList);

      final index = listFinancialEntity.indexWhere(
        (financialEntity) => financialEntity.purchases
            .any((compra) => compra.id == event.purchaseList.first.id),
      );

      final modifiedFinancialEntity = listFinancialEntity[index];

      final updatedEntity = modifiedFinancialEntity.copyWith(
        purchases: [
          ...modifiedFinancialEntity.purchases.map(
            (compra) =>
                event.purchaseList.any((purchase) => purchase.id == compra.id)
                    ? modifiedPurchasesResponse.body.firstWhere(
                        (purchase) => purchase.id == compra.id,
                      )
                    : compra,
          ),
        ],
      );

      listFinancialEntity[index] = updatedEntity;

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

      await _purchasesRepository.ignorePurchase(
        purchaseId: purchaseToModify.id,
      );

      final index = listFinancialEntity.indexOf(financialEntityModified);

      listFinancialEntity[index] = financialEntityModified.copyWith(
        purchases: financialEntityModified.purchases
            .map(
              (compra) => compra.id == event.purchaseId
                  ? purchaseToModify.copyWith(
                      ignored: !purchaseToModify.ignored,
                    )
                  : compra,
            )
            .toList(),
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

  Future<void> _onSelectFinancialEntity(
    BlocDashboardEventSelectFinancialEntity event,
    Emitter<BlocDashboardState> emit,
  ) async {
    final lastMovements = await _purchasesRepository.getLastMovements(
      financialEntityId: event.financialEntity.id,
    );
    add(BlocDashboardEventInitialize());
    emit(
      BlocDashboardStateSuccess.from(
        state,
        financialEntitySelected: event.financialEntity,
        lastMovements: lastMovements.body,
      ),
    );
  }

  Future<void> _onSelectCurrency(
    BlocDashboardEventSelectCurrency event,
    Emitter<BlocDashboardState> emit,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt('currency', event.selectedCurrency.value);

    emit(
      BlocDashboardStateSuccess.from(
        state,
        selectedCurrency: event.selectedCurrency,
      ),
    );
  }
}

///
Future<String> uploadImage(XFile image, String nombre) async {
  final url =
      Uri.parse('https://api.cloudinary.com/v1_1/dkdwnhsxf/image/upload');

  try {
    // Crea un multipart request
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'purchasemanager'
      ..fields['public_id'] = nombre
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    // Envía la solicitud
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final responses = jsonDecode(responseData);

      final nombre = responses['url'] as String;
      return nombre;
    } else {
      throw Exception('Error al subir la imagen: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Excepción al subir la imagen: $e');
  }
}

/// Elimina una imagen de Cloudinary
Future<String> deleteImage(String publicId) async {
  const cloudName = 'dkdwnhsxf'; // Reemplaza con tu nombre de cuenta
  const apiKey = '957695417391746'; // Reemplaza con tu API Key
  const apiSecret =
      'GLj70y-rNOsQO8dpjQESO5L7HJg'; // Reemplaza con tu API Secret

  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  // Generar string para firmar
  final stringToSign = 'public_id=$publicId&timestamp=$timestamp';

  // Crear firma usando SHA-1
  final signature =
      sha1.convert(utf8.encode('$stringToSign$apiSecret')).toString();

  final url =
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');

  try {
    final response = await http.post(
      url,
      body: {
        'public_id': publicId,
        'signature': signature,
        'api_key': apiKey,
        'timestamp': timestamp.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['result'] == 'ok') {
        return 'Imagen eliminada exitosamente.';
      } else {
        throw Exception('Error en la respuesta: ${responseData['result']}');
      }
    } else {
      throw Exception(
        'Error en el servidor: Código ${response.statusCode}. Mensaje: '
        '${response.reasonPhrase}',
      );
    }
  } catch (e) {
    throw Exception('Excepción al eliminar la imagen: $e');
  }
}
