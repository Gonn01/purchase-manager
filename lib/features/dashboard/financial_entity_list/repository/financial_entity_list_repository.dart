import 'package:purchase_manager/features/dashboard/financial_entity_list/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
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

  static Future<ResponseLD<FinancialEntityListDto>> createFinancialEntity(
      String financialEntityName) async {
    final response = await Repository.post<FinancialEntityListDto>(
      url: '${Config.apiUrl}/financial-entities/',
      fromJson: (jsonData) => FinancialEntityListDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': financialEntityName,
      },
    );

    return response;
  }
}
