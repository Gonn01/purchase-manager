import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_home_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<ResponseLD<FinancialEntityHomeDto>> createFinancialEntity({
    required String financialEntityName,
    required String firebaseUserId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt('user_id');

    final response = await Repository.post<FinancialEntityHomeDto>(
      url: '${Config.apiUrl}/financial-entity/',
      fromJson: (jsonData) => FinancialEntityHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': financialEntityName,
        'userId': userId,
      },
    );

    return response;
  }
}
