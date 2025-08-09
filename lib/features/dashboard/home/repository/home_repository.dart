import 'package:purchase_manager/features/dashboard/home/dtos/financial_entity_home_dto.dart';
import 'package:purchase_manager/features/dashboard/home/dtos/purchase_home_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class HomeRepository {
  /// Base URL de la API
  static final purchaseUrls = '${Config.apiUrl}/purchases/';

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
    final url = purchaseUrls;
    final response = await Repository.post(
      url: url,
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
        'number_of_quotas': numberOfQuotas,
        'payed_quotas': payedQuotas,
        'image': image,
      },
    );

    return response;
  }

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
