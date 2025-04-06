import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/pm_response.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template PurchasesRepository}
/// Repositorio de compras
///
/// /// Purchases repository
/// {@endtemplate}
class PurchasesRepository {
  /// Base URL de la API
  final baseUrl = '${Config.apiUrl}/purchases/';

  /// Metodo para crear una compra
  ///
  /// Method to create a purchase
  Future<PMResponse<Purchase>> createPurchase({
    required String? image,
    required double amount,
    required double amountPerQuota,
    required int payedQuotas,
    required CurrencyType currencyType,
    required String purchaseName,
    required PurchaseType purchaseType,
    required bool fixedExpense,
    required bool ignored,
    required int numberOfQuotas,
    required int financialEntityId,
  }) async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'image': image,
          'amount': amount,
          'numberOfQuotas': numberOfQuotas,
          'amountPerQuota': amountPerQuota,
          'payedQuotas': payedQuotas,
          'currencyType': currencyType.value,
          'name': purchaseName,
          'purchaseType': purchaseType.value,
          'fixedExpense': fixedExpense,
          'ignored': ignored,
          'financialEntityId': financialEntityId,
        }),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => Purchase.fromJson(
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

  Future<void> deletePurchase({
    required int purchaseId,
  }) async {
    final url = Uri.parse(baseUrl + purchaseId.toString());
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => <void>{},
        ),
        jsonData,
      );
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<Purchase>> editPurchase({
    required int purchaseId,
    required String? image,
    required double amount,
    required int payedQuotas,
    required CurrencyType currencyType,
    required String purchaseName,
    required PurchaseType purchaseType,
    required bool fixedExpense,
    required bool ignored,
    required int numberOfQuotas,
    required int financialEntityId,
  }) async {
    final url = Uri.parse(baseUrl + purchaseId.toString());
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'ignored': ignored,
          'image': image,
          'amount': amount,
          'numberOfQuotas': numberOfQuotas,
          'payedQuotas': payedQuotas,
          'currencyType': currencyType.index,
          'name': purchaseName,
          'amountPerQuota': numberOfQuotas == 0 ? 0 : amount / numberOfQuotas,
          'purchaseType': purchaseType.index,
          'financialEntityId': financialEntityId,
          'fixedExpense': fixedExpense,
        }),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => Purchase.fromJson(
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

  Future<PMResponse<List<Purchase>>> getPurchasesByFinancialEntityId({
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
              .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<Purchase>> getPurchaseById({
    required int purchaseId,
  }) async {
    final url = Uri.parse(baseUrl + purchaseId.toString());
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
          (json) => Purchase.fromJson(
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

  Future<PMResponse<List<Purchase>>> getPurchasesByUserId({
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
              .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<Purchase>> payQuota({
    required int purchaseId,
  }) async {
    final url = Uri.parse('$baseUrl$purchaseId/pay-quota');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      return handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => Purchase.fromJson(
            jsonData['body'] as Map<String, dynamic>,
          ),
        ),
        jsonData,
      );
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<List<Purchase>>> payMonth({
    required List<int> purchaseIds,
  }) async {
    final url = Uri.parse('$baseUrl' 'pay-month');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'purchaseIds': purchaseIds,
        }),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      return handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => (jsonData['body'] as List)
              .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        jsonData,
      );
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<PMResponse<Purchase>> unpayQuota({
    required int purchaseId,
  }) async {
    final url = Uri.parse('$baseUrl$purchaseId/unpay-quota');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      return handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => Purchase.fromJson(
            jsonData['body'] as Map<String, dynamic>,
          ),
        ),
        jsonData,
      );
    } catch (e, st) {
      handleException(e, st);
    }
  }

  Future<void> ignorePurchase({
    required int purchaseId,
  }) async {
    final url = Uri.parse('$baseUrl$purchaseId/ignore');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) {},
        ),
        jsonData,
      );
    } catch (e, st) {
      handleException(e, st);
    }
  }
}
