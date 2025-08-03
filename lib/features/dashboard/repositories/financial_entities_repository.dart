import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class FinancialEntitiesRepository {
  static final baseUrl = '${Config.apiUrl}/financial-entities/';

  static Future<ResponseLD<FinancialEntity>> editFinancialEntity({
    required String financialEntityId,
    required String newName,
  }) async {
    final url = baseUrl + financialEntityId;

    final response = await Repository.put<FinancialEntity>(
      url: url,
      fromJson: (jsonData) => FinancialEntity.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': newName,
      },
    );

    return response;
  }
}
