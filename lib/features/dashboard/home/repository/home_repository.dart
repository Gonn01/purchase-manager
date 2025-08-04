import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_home_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class HomeRepository {
  static Future<List<FinancialEntityHomeDto>> getHomeData() async {
    final url = '${Config.apiUrl}/home/';

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map(
              (e) => FinancialEntityHomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response.body ?? [];
  }
}
