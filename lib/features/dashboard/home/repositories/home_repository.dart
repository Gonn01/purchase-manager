import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/pm_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final baseUrl = '${Config.apiUrl}/home/';

  Future<PMResponse<List<FinancialEntity>>> getHomeData() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final userId = preferences.getInt('user_id');

      final url = Uri.parse('$baseUrl$userId');

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => (jsonData['body'] as List)
              .map((e) => FinancialEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }
}
