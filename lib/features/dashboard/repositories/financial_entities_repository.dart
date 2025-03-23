// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/pm_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinancialEntitiesRepository {
  final baseUrl = '${Config.apiUrl}/financial-entities/';

  Future<PMResponse<FinancialEntity>> createFinancialEntity({
    required String financialEntityName,
    required String firebaseUserId,
  }) async {
    final url = Uri.parse(baseUrl);
    final preferences = await SharedPreferences.getInstance();

    final userId = preferences.getInt('user_id');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': financialEntityName,
          'userId': userId,
        }),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => FinancialEntity.fromJson(
            jsonData['body'] as Map<String, dynamic>,
          ),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<FinancialEntity>> deleteFinancialEntity({
    required int financialEntityId,
  }) async {
    final url = Uri.parse(baseUrl + financialEntityId.toString());
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => FinancialEntity.fromJson(
            jsonData['body'] as Map<String, dynamic>,
          ),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<FinancialEntity>> editFinancialEntity({
    required String financialEntityId,
    required String newName,
  }) async {
    final url = Uri.parse(baseUrl + financialEntityId);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          'name': newName,
        },
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => FinancialEntity.fromJson(
            jsonData['body'] as Map<String, dynamic>,
          ),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<List<FinancialEntity>>> getFinancialEntities({
    required int userId,
  }) async {
    final url = Uri.parse(baseUrl);
    try {
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
