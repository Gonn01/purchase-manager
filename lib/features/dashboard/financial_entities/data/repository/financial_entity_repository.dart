import 'package:purchase_manager/features/dashboard/financial_entities/data/dtos/financial_entity_details_dto.dart';
import 'package:purchase_manager/features/dashboard/financial_entities/data/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class FinancialEntityListRepository {
  static final baseUrl = '${Config.apiUrl}/financial-entities/';

  static Future<ResponseLD<List<FinancialEntityListDto>>>
      getFinancialEntities() async {
    final url = baseUrl;
    final response = await Repository.get<List<FinancialEntityListDto>>(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map(
              (e) => FinancialEntityListDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<void>> deleteFinancialEntity({
    required int financialEntityId,
  }) async {
    final url = '$baseUrl$financialEntityId';
    final response = await Repository.delete<void>(
        url: url, fromJson: (jsonData) => <void>{});
    return response;
  }

  static Future<ResponseLD<FinancialEntityDetailsDto>>
      getFinancialEntityDetails({required int financialEntityId}) async {
    final url = '$baseUrl$financialEntityId/details/';

    final response = await Repository.get<FinancialEntityDetailsDto>(
      url: url,
      fromJson: (jsonData) => FinancialEntityDetailsDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<FinancialEntityDetailsDto>> editFinancialEntity({
    required String financialEntityId,
    required String newName,
  }) async {
    final response = await Repository.put<FinancialEntityDetailsDto>(
      url: '$baseUrl$financialEntityId/',
      fromJson: (jsonData) => FinancialEntityDetailsDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': newName,
      },
    );

    return response;
  }

  static Future<ResponseLD<List<Purchase>>> getPurchasesByFinancialEntityId({
    required int userId,
  }) async {
    final url = baseUrl;

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<Purchase>> getPurchaseById({
    required int purchaseId,
  }) async {
    final url = baseUrl + purchaseId.toString();

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }
}
