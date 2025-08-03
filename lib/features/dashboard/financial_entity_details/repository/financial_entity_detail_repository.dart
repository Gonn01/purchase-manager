import 'package:purchase_manager/features/dashboard/financial_entity_details/dtos/financial_entity_details_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class FinancialEntityDetailRepository {
  static final baseUrl = '${Config.apiUrl}/financial-entities/';

  static Future<ResponseLD<FinancialEntityDetailsDto>> getFinancialEntity(
      {required int financialEntityId}) async {
    final url = '$baseUrl$financialEntityId/detail/';

    final response = await Repository.get<FinancialEntityDetailsDto>(
      url: url,
      fromJson: (jsonData) => FinancialEntityDetailsDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }
}
