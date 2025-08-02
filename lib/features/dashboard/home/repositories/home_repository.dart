import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_with_purchases_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository {
  static final baseUrl = '${Config.apiUrl}/home/';

  static Future<List<FinancialEntityWithPurchasesDto>> getHomeData() async {
    final preferences = await SharedPreferences.getInstance();

    final userId = preferences.getInt('user_id');

    final url = '$baseUrl$userId';

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => FinancialEntityWithPurchasesDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

    return response.body ?? [];
  }
}
