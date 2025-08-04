import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_home_dto.dart';
import 'package:purchase_manager/features/dashboard/home/dtos/purchase_home_dto.dart';
import 'package:purchase_manager/features/dashboard/home/repository/home_repository.dart';
import 'package:purchase_manager/features/dashboard/repositories/purchases_repository.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/exception.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _onInitialize(
    BlocHomeEventInitialize event,
    Emitter<BlocHomeState> emit,
  ) async {
    emit(BlocHomeStateLoading.from(state));
    try {
      final responseListFinancialeEntity = await HomeRepository.getHomeData();

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: responseListFinancialeEntity,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
          state,
          exception: e is CustomException
              ? e
              : CustomException(
                  title: e.toString(),
                  message: 'An error occurred during initialization.',
                ),
        ),
      );
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
      final dto = state.financialEntityList.firstWhere(
        (fe) => fe.id == event.financialEntityId,
      );

      final purchaseResult = findPurchaseInDto(dto, event.purchaseId);

      if (purchaseResult == null) {
        throw CustomException(
          title: 'Compra no encontrada',
          message: 'No se encontró la compra con ID ${event.purchaseId}.',
        );
      }

      final modifiedPurchaseResponse = await PurchasesRepository.unpayQuota(
        purchaseId: purchaseResult.purchase.id,
      );

      final modifiedPurchase = modifiedPurchaseResponse.body!;

      final updatedDto = updatePurchaseInDto(dto, modifiedPurchase);

      final newList = state.financialEntityList
          .map(
            (fe) => fe.id == updatedDto.id ? updatedDto : fe,
          )
          .toList();

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
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
      // Copio la lista de DTOs (no FinancialEntity simple)
      final listFinancialEntity =
          List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Busco el DTO que contiene la compra
      final modifiedDto = listFinancialEntity.firstWhere(
        (dto) =>
            dto.currentPurchases.any((c) => c.id == event.idPurchase) ||
            dto.settledPurchases.any((c) => c.id == event.idPurchase),
      );

      final purchaseResult = findPurchaseInDto(modifiedDto, event.idPurchase);

      if (purchaseResult == null) {
        throw CustomException(
          title: 'Compra no encontrada',
          message: 'No se encontró la compra con ID ${event.idPurchase}.',
        );
      }

      final modifiedPurchaseResponse = await PurchasesRepository.payQuota(
        purchaseId: purchaseResult.purchase.id,
      );

      final modifiedPurchase = modifiedPurchaseResponse.body!;

      // Creo un nuevo DTO actualizando solo la compra encontrada
      final updatedDto = updatePurchaseInDto(modifiedDto, modifiedPurchase);

      // Reemplazo el DTO en la lista
      final newList = listFinancialEntity
          .map(
            (dto) => dto.id == updatedDto.id ? updatedDto : dto,
          )
          .toList();

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
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

  Future<void> _onCreatePurchase(
    BlocHomeEventCreatePurchase event,
    Emitter<BlocHomeState> emit,
  ) async {
    try {
      String? url;

      if (state.images.isNotEmpty) {
        url = await uploadImage(state.images.first, event.productName);
      }

      final newPurchaseResponse = await PurchasesRepository.createPurchase(
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

      final newPurchase = newPurchaseResponse.body!;

      // Copio la lista de DTOs
      final newList =
          List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Busco la entidad a actualizar
      final index = newList.indexWhere(
        (dto) => dto.id == event.financialEntity.id,
      );

      if (index == -1) {
        throw const CustomException(
          title: 'Entidad no encontrada',
          message: 'No se encontró la entidad financiera para crear la compra.',
        );
      }

      // Actualizo la entidad con la nueva compra en currentPurchases
      final updatedEntity = FinancialEntityHomeDto(
        id: newList[index].id,
        name: newList[index].name,
        currentPurchases: [...newList[index].currentPurchases, newPurchase],
        settledPurchases: newList[index].settledPurchases,
      );

      // Reemplazo la entidad en la lista
      newList[index] = updatedEntity;

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: newList,
          deleteImage: true,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
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
      // Manejo de imagen
      if (state.images.isNotEmpty) {
        await deleteImage('public/purchase-manager/${event.purchase.name}');
        await uploadImage(state.images.first, event.name);
      }

      final modifiedPurchaseResponse = await PurchasesRepository.editPurchase(
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

      final modifiedPurchase = modifiedPurchaseResponse.body!;

      // Copio la lista de DTOs
      final listFinancialEntity =
          List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Busco la entidad a modificar
      final index = listFinancialEntity.indexWhere(
        (dto) =>
            dto.id == event.idFinancialEntity &&
            (dto.currentPurchases.any((c) => c.id == event.purchase.id) ||
                dto.settledPurchases.any((c) => c.id == event.purchase.id)),
      );

      if (index != -1) {
        final targetDto = listFinancialEntity[index];

        // Actualizo la compra en la lista correspondiente
        final updatedDto = FinancialEntityHomeDto(
          id: targetDto.id,
          name: targetDto.name,
          currentPurchases: targetDto.currentPurchases.map((c) {
            return c.id == event.purchase.id ? modifiedPurchase : c;
          }).toList(),
          settledPurchases: targetDto.settledPurchases.map((c) {
            return c.id == event.purchase.id ? modifiedPurchase : c;
          }).toList(),
        );

        // Reemplazo la entidad en la lista
        listFinancialEntity[index] = updatedDto;
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
      emit(
        BlocHomeStateError.from(
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
      await PurchasesRepository.deletePurchase(
        purchaseId: event.purchase.id,
      );

      // Copiamos la lista de DTOs
      final list = List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Buscamos la entidad financiera
      final index = list.indexWhere(
        (dto) => dto.id == event.idFinancialEntity,
      );

      if (index == -1) {
        throw CustomException(
          title: 'Entidad no encontrada',
          message:
              'No se encontró la entidad financiera con ID ${event.idFinancialEntity}.',
        );
      }

      final targetDto = list[index];

      // Creamos un nuevo DTO eliminando la compra tanto de current como de settled
      final updatedEntity = FinancialEntityHomeDto(
        id: targetDto.id,
        name: targetDto.name,
        currentPurchases: targetDto.currentPurchases
            .where((purchase) => purchase.id != event.purchase.id)
            .toList(),
        settledPurchases: targetDto.settledPurchases
            .where((purchase) => purchase.id != event.purchase.id)
            .toList(),
      );

      // Reemplazamos la entidad actualizada en la lista
      list[index] = updatedEntity;

      emit(BlocHomeStateSuccess.from(state, financialEntityList: list));
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
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

      final modifiedPurchasesResponse = await PurchasesRepository.payMonth(
        purchaseIds: purchaseIds,
      );

      final updatedPurchases = modifiedPurchasesResponse.body!;

      // Copio la lista de DTOs
      final listFinancialEntity =
          List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Encuentro la entidad financiera (usando el primer id como referencia)
      final index = listFinancialEntity.indexWhere(
        (dto) =>
            dto.currentPurchases
                .any((c) => c.id == event.purchaseList.first.id) ||
            dto.settledPurchases
                .any((c) => c.id == event.purchaseList.first.id),
      );

      if (index == -1) {
        throw const CustomException(
          title: 'Entidad no encontrada',
          message: 'No se encontró la entidad financiera para pagar el mes.',
        );
      }

      final targetDto = listFinancialEntity[index];

      // Actualizo currentPurchases
      final updatedCurrentPurchases = targetDto.currentPurchases.map((c) {
        final match = updatedPurchases.firstWhere(
          (u) => u.id == c.id,
        );
        return match;
      }).toList();

      // Actualizo settledPurchases
      final updatedSettledPurchases = targetDto.settledPurchases.map((c) {
        final match = updatedPurchases.firstWhere(
          (u) => u.id == c.id,
        );
        return match;
      }).toList();

      // Nuevo DTO con listas actualizadas
      final updatedEntity = FinancialEntityHomeDto(
        id: targetDto.id,
        name: targetDto.name,
        currentPurchases: updatedCurrentPurchases,
        settledPurchases: updatedSettledPurchases,
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
      emit(
        BlocHomeStateError.from(
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
      // Copiamos la lista de DTOs
      final listFinancialEntity =
          List<FinancialEntityHomeDto>.from(state.financialEntityList);

      // Buscamos la entidad que contiene la compra
      final financialEntityModified = listFinancialEntity.firstWhere(
        (dto) =>
            dto.currentPurchases.any((c) => c.id == event.purchaseId) ||
            dto.settledPurchases.any((c) => c.id == event.purchaseId),
      );

      // Buscamos la compra dentro del DTO
      final purchaseToModify = [
        ...financialEntityModified.currentPurchases,
        ...financialEntityModified.settledPurchases,
      ].firstWhere((c) => c.id == event.purchaseId);

      // Toggle ignored en el backend
      await PurchasesRepository.ignorePurchase(
        purchaseId: purchaseToModify.id,
      );

      // Reemplazamos la compra ignorada en las listas correspondientes
      final updatedDto = FinancialEntityHomeDto(
        id: financialEntityModified.id,
        name: financialEntityModified.name,
        currentPurchases: financialEntityModified.currentPurchases.map((c) {
          return c.id == event.purchaseId ? c.copyWith(ignored: !c.ignored) : c;
        }).toList(),
        settledPurchases: financialEntityModified.settledPurchases.map((c) {
          return c.id == event.purchaseId ? c.copyWith(ignored: !c.ignored) : c;
        }).toList(),
      );

      // Reemplazamos el DTO en la lista
      final index = listFinancialEntity.indexOf(financialEntityModified);
      listFinancialEntity[index] = updatedDto;

      emit(
        BlocHomeStateSuccess.from(
          state,
          financialEntityList: listFinancialEntity,
          deleteSelectedShipmentId: true,
        ),
      );
    } on Exception catch (e) {
      emit(
        BlocHomeStateError.from(
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

class PurchaseResult {
  final PurchaseHomeDto purchase;
  final PurchaseType type; // "current" o "settled"

  PurchaseResult({required this.purchase, required this.type});
}

PurchaseResult? findPurchaseInDto(
  FinancialEntityHomeDto dto,
  int purchaseId,
) {
  for (final p in dto.currentPurchases) {
    if (p.id == purchaseId) {
      return PurchaseResult(purchase: p, type: p.type);
    }
  }
  for (final p in dto.settledPurchases) {
    if (p.id == purchaseId) {
      return PurchaseResult(purchase: p, type: p.type);
    }
  }
  return null;
}

/// Retorna un nuevo DTO con la compra actualizada
FinancialEntityHomeDto updatePurchaseInDto(
  FinancialEntityHomeDto dto,
  PurchaseHomeDto updatedPurchase,
) {
  return FinancialEntityHomeDto(
    id: dto.id,
    name: dto.name,
    currentPurchases: dto.currentPurchases
        .map((p) => p.id == updatedPurchase.id ? updatedPurchase : p)
        .toList(),
    settledPurchases: dto.settledPurchases
        .map((p) => p.id == updatedPurchase.id ? updatedPurchase : p)
        .toList(),
  );
}
