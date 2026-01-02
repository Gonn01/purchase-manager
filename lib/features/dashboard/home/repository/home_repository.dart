import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_home_dto.dart';
import 'package:purchase_manager/features/dashboard/home/dtos/purchase_home_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class HomeRepository {
  /// Base URL de la API
  static final homeBaseUrl = '${Config.apiUrl}/home';
  static final homeFinancialEntitiesBaseUrl =
      '$homeBaseUrl/financial-entities/';
  static final homePurchasesBaseUrl = '$homeBaseUrl/purchases/';

  static Future<List<FinancialEntityHomeDto>> getHomeData() async {
    final response = await Repository.get(
      url: homeBaseUrl,
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map(
              (e) => FinancialEntityHomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    return response.body ?? [];
  }

  static Future<ResponseLD<FinancialEntityHomeDto>> createFinancialEntity(
      String financialEntityName) async {
    final response = await Repository.post<FinancialEntityHomeDto>(
      url: homeFinancialEntitiesBaseUrl,
      fromJson: (jsonData) => FinancialEntityHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'name': financialEntityName,
      },
    );

    return response;
  }

  /// Metodo para crear una compra
  ///
  /// Method to create a purchase
  static Future<ResponseLD<PurchaseHomeDto>> createPurchase({
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
    final response = await Repository.post(
      url: homePurchasesBaseUrl,
      fromJson: (jsonData) => PurchaseHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
      body: {
        'financial_entity_id': financialEntityId,
        'type': purchaseType.value,
        'fixed_expense': fixedExpense,
        'ignored': ignored,
        'name': purchaseName,
        'amount': amount,
        'currency_type': currencyType.value,
        'number_of_quotas': numberOfQuotas == 0 ? 1 : numberOfQuotas,
        'payed_quotas': payedQuotas,
        'image': image,
      },
    );

    return response;
  }

  static Future<ResponseLD<PurchaseHomeDto>> editPurchase({
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
    final response = await Repository.put(
      url: homePurchasesBaseUrl + purchaseId.toString(),
      fromJson: (jsonData) => PurchaseHomeDto.fromJson(
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

  static Future<ResponseLD<void>> deletePurchase({
    required int purchaseId,
  }) async {
    final response = await Repository.delete(
      url: homePurchasesBaseUrl + purchaseId.toString(),
      fromJson: (jsonData) => ResponseLD.fromJson(
        jsonData,
        (json) => <void>{},
      ),
    );
    return response;
  }

  static Future<ResponseLD<PurchaseHomeDto>> ignorePurchase({
    required int purchaseId,
  }) async {
    final response = await Repository.put(
      url: '$homePurchasesBaseUrl$purchaseId/ignore',
      fromJson: (jsonData) => PurchaseHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<PurchaseHomeDto>> payQuota({
    required int purchaseId,
  }) async {
    final response = await Repository.put(
      url: '$homePurchasesBaseUrl$purchaseId/pay-quota',
      fromJson: (jsonData) => PurchaseHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );

    return response;
  }

  static Future<ResponseLD<PurchaseHomeDto>> unpayQuota({
    required int purchaseId,
  }) async {
    final response = await Repository.put(
      url: '$homePurchasesBaseUrl$purchaseId/unpay-quota',
      fromJson: (jsonData) => PurchaseHomeDto.fromJson(
        jsonData['body'] as Map<String, dynamic>,
      ),
    );
    return response;
  }

  static Future<ResponseLD<List<PurchaseHomeDto>>> payMonth({
    required List<int> purchaseIds,
  }) async {
    final response = await Repository.put(
      url: '$homePurchasesBaseUrl/pay-month',
      fromJson: (jsonData) => (jsonData['body'] as List)
          .map((e) => PurchaseHomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      body: {
        'purchaseIds': purchaseIds,
      },
    );
    return response;
  }
}
