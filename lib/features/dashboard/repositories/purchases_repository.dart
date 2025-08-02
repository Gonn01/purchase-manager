import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

/// {@template PurchasesRepository}
/// Repositorio de compras
///
/// /// Purchases repository
/// {@endtemplate}
abstract class PurchasesRepository {
  /// Base URL de la API
  static final baseUrl = '${Config.apiUrl}/purchases/';

  /// Metodo para crear una compra
  ///
  /// Method to create a purchase
  static Future<ResponseLD<Purchase>> createPurchase({
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
    final url = baseUrl;
    final response = await Repository.post(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
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
      },
    );

    return response;
  }

  static Future<ResponseLD<void>> deletePurchase({
    required int purchaseId,
  }) async {
    final url = baseUrl + purchaseId.toString();

    final response = await Repository.delete(
      url: url,
      fromJson: (jsonData) => ResponseLD.fromJson(
        jsonData,
        (json) => <void>{},
      ),
    );
    return response;
  }

  static Future<ResponseLD<Purchase>> editPurchase({
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
    final url = baseUrl + purchaseId.toString();

    final response = await Repository.put(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'ignored': ignored,
        'image': image,
        'amount': amount,
        'numberOfQuotas': numberOfQuotas,
        'payedQuotas': payedQuotas,
        'currencyType': currencyType.value,
        'name': purchaseName,
        'amountPerQuota': numberOfQuotas == 0 ? 0 : amount / numberOfQuotas,
        'purchaseType': purchaseType.value,
        'financialEntityId': financialEntityId,
        'fixedExpense': fixedExpense,
      },
    );
    return response;
  }

  static Future<ResponseLD<List<Purchase>>> getPurchasesByFinancialEntityId({
    required int userId,
  }) async {
    final url = baseUrl;

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<Purchase>> getPurchaseById({
    required int purchaseId,
  }) async {
    final url = baseUrl + purchaseId.toString();

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<List<Purchase>>> getPurchasesByUserId({
    required int userId,
  }) async {
    final url = baseUrl;

    final response = await Repository.get(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  static Future<ResponseLD<Purchase>> payQuota({
    required int purchaseId,
  }) async {
    final url = '$baseUrl$purchaseId/pay-quota';
    final response = await Repository.put(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<List<Purchase>>> payMonth({
    required List<int> purchaseIds,
  }) async {
    final url = '$baseUrl/pay-month';
    final response = await Repository.put(
      url: url,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
      body: {
        'purchaseIds': purchaseIds,
      },
    );
    return response;
  }

  static Future<ResponseLD<Purchase>> unpayQuota({
    required int purchaseId,
  }) async {
    final url = '$baseUrl$purchaseId/unpay-quota';
    final response = await Repository.put(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );
    return response;
  }

  static Future<ResponseLD<Purchase>> ignorePurchase({
    required int purchaseId,
  }) async {
    final url = '$baseUrl$purchaseId/ignore';
    final response = await Repository.put(
      url: url,
      fromJson: (jsonData) => Purchase.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }
}
