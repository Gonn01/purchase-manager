import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:purchase_manager/features/dashboard/home/repositories/home_repository.dart';
import 'package:purchase_manager/features/dashboard/repositories/financial_entities_repository.dart';
import 'package:purchase_manager/features/dashboard/repositories/purchases_repository.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

part 'bloc_home_event.dart';
part 'bloc_home_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocHome extends Bloc<BlocHomeEvent, BlocHomeState> {
  /// {@macro BlocInicio}
  BlocHome() : super(BlocHomeStateInitial()) {
    on<BlocHomeEventInitialize>(_onInitialize);
    on<BlocHomeEventIncreaseAmountOfQuotas>(_onIncreaseAmountOfQuotas);
    on<BlocHomeEventPayQuota>(_onPayQuota);
    on<BlocHomeEventCreateFinancialEntity>(_onCreateFinancialEntity);
    on<BlocHomeEventCreatePurchase>(_onCreatePurchase);
    on<BlocHomeEventEditPurchase>(_onEditPurchase);
    on<BlocHomeEventDeletePurchase>(_onDeletePurchase);
    on<BlocHomeEventPayMonth>(_onPayMonth);
    on<BlocHomeEventAlternateIgnorePurchase>(_onAlternateIgnorePurchase);
    on<BlocHomeEventAddImage>(_onAddImage);
    on<BlocHomeEventDeleteImageAt>(_onDeleteImageAt);

    add(BlocHomeEventInitialize());
  }

  /// Instancia de FirebaseAuth
  ///
  /// FirebaseAuth instance
  final auth = FirebaseAuth.instance;

  final _purchasesRepository = PurchasesRepository();

  final _financialEntitiesRepository = FinancialEntitiesRepository();

  final _homeRepository = HomeRepository();

  Future<void> _onInitialize(
    BlocHomeEventInitialize event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      final responseListFinancialeEntity = await _homeRepository.getHomeData();

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: responseListFinancialeEntity.body,
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
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
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
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
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
      final newFinancialEntityResponse =
          await _financialEntitiesRepository.createFinancialEntity(
        financialEntityName: event.financialEntityName,
        firebaseUserId: auth.currentUser?.uid ?? '',
      );

      final list = List<FinancialEntity>.from(state.financialEntityList)
        ..add(
          newFinancialEntityResponse.body,
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
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
          deleteImage: true,
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
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
          deleteImage: true,
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
      final purchaseIds = event.purchaseList.map((e) => e.id).toList();
      emit(
        BlocHomeStateLoadingPurchase.from(
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

  Future<void> _onAlternateIgnorePurchase(
    BlocHomeEventAlternateIgnorePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(
      BlocHomeStateLoadingPurchase.from(
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

  void _onAddImage(
    BlocHomeEventAddImage event,
    Emitter<BlocHomeState> emit,
  ) {
    final images = List<XFile>.from(state.images)..add(event.image);

    emit(BlocHomeStateSuccess.from(state, images: images));
  }

  void _onDeleteImageAt(
    BlocHomeEventDeleteImageAt event,
    Emitter<BlocHomeState> emit,
  ) {
    final images = List<XFile>.from(state.images)..removeAt(event.index);

    emit(BlocHomeStateSuccess.from(state, images: images));
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
