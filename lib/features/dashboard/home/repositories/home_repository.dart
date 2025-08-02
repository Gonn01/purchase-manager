import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository {
  static final baseUrl = '${Config.apiUrl}/home/';

  static Future<ResponseLD<List<FinancialEntity>>> getHomeData() async {
    final preferences = await SharedPreferences.getInstance();

    final userId = preferences.getInt('user_id');

    final url = '$baseUrl$userId';

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => FinancialEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }
}
