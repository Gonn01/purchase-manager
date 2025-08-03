import 'package:purchase_manager/features/dashboard/financial_entity_list/dtos/financial_entity_list_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinancialEntityListRepository {
  static final baseUrl = '${Config.apiUrl}/financial-entities/';

  static Future<ResponseLD<void>> deleteFinancialEntity({
    required int financialEntityId,
  }) async {
    final url = '$baseUrl$financialEntityId';
    final response = await Repository.delete<void>(
        url: url, fromJson: (jsonData) => <void>{});
    return response;
  }

  static Future<ResponseLD<List<FinancialEntityDto>>>
      getFinancialEntities() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt('user_id');

    final url = '${baseUrl}user/$userId';
    final response = await Repository.get<List<FinancialEntityDto>>(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => FinancialEntityDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }
}
