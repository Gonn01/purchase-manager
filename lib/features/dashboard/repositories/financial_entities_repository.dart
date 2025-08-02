import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/logs.dart';
import 'package:purchase_manager/utilities/models/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FinancialEntitiesRepository {
  static final baseUrl = '${Config.apiUrl}/financial-entities/';

  static Future<ResponseLD<FinancialEntity>> createFinancialEntity({
    required String financialEntityName,
    required String firebaseUserId,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt('user_id');

    final response = await Repository.post<FinancialEntity>(
      url: baseUrl,
      fromJson: (jsonData) => FinancialEntity.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': financialEntityName,
        'userId': userId,
      },
    );

    return response;
  }

  static Future<ResponseLD<void>> deleteFinancialEntity({
    required int financialEntityId,
  }) async {
    final url = baseUrl + financialEntityId.toString();
    final response = await Repository.delete<void>(
        url: url, fromJson: (jsonData) => <void>{});
    return response;
  }

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

  static Future<ResponseLD<List<FinancialEntity>>> getFinancialEntities({
    required int userId,
  }) async {
    final url = baseUrl + userId.toString();
    final response = await Repository.get<List<FinancialEntity>>(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => FinancialEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<FinancialEntity>> getFinancialEntity() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt('user_id');

    final url = baseUrl + userId.toString();

    final response = await Repository.get<FinancialEntity>(
      url: url,
      fromJson: (jsonData) => FinancialEntity.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<List<LastMovementLog>>> getLastMovements({
    required int financialEntityId,
  }) async {
    final url = '${baseUrl}logs/$financialEntityId';

    final response = await Repository.get<List<LastMovementLog>>(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => LastMovementLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }
}
