// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/functions/generate_text_2.dart';
import 'package:purchase_manager/utilities/functions/total_amount.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_financial_entity.dart';
import 'package:purchase_manager/utilities/functions/total_amount_per_month.dart';
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template CurrencyType}
/// Tipo de moneda.
///
/// Currency type.
/// {@endtemplate}
enum CurrencyType {
  /// Peso argentino.
  ///
  /// Argentine peso.
  pesoArgentino,

  /// Dólar estadounidense.
  ///
  /// US dollar.
  usDollar,

  /// Euro.
  euro;

  /// Crea una instancia de [CurrencyType] a partir de un valor entero.
  ///
  /// Creates an instance of [CurrencyType] from an integer value.
  static CurrencyType type(int value) {
    return switch (value) {
      0 => CurrencyType.pesoArgentino,
      1 => CurrencyType.usDollar,
      2 => CurrencyType.euro,
      _ => throw Exception('Invalid purchase type'),
    };
  }

  /// Devuelve el valor entero del tipo de moneda.
  ///
  /// Returns the integer value of the currency type.
  int get value => switch (this) {
        CurrencyType.pesoArgentino => 0,
        CurrencyType.usDollar => 1,
        CurrencyType.euro => 2,
      };

  /// Devuelve el nombre del tipo de moneda.
  ///
  /// Returns the name of the currency type.
  String get abreviation => switch (this) {
        CurrencyType.pesoArgentino => 'ARS',
        CurrencyType.usDollar => 'USD',
        CurrencyType.euro => 'EUR',
      };

  /// Devuelve la cantidad total de una lista de [Purchase] de una entidad
  /// financiera.
  ///
  /// Returns the total amount of a list of [Purchase] of a financial entity.
  double totalAmountPerFinancialEntity({
    required List<Purchase> purchases,
    required Currency currency,
  }) {
    switch (this) {
      case CurrencyType.pesoArgentino:
        return totalAmountPerFinancialEntityPesos(
          currency: currency,
          purchases: purchases,
        );
      case CurrencyType.usDollar:
        return totalAmountPerFinancialEntityDolar(
          currency: currency,
          purchases: purchases,
        );
      case CurrencyType.euro:
        return totalAmountPerFinancialEntityEuro(
          currency: currency,
          purchases: purchases,
        );
    }
  }

  /// Devuelve la cantidad total de una lista de [FinancialEntity] en un mes.
  ///
  /// Returns the total amount of a list of [FinancialEntity] in a month.
  double totalAmountPerMonth({
    required List<FinancialEntity> financialEntities,
    required Currency currency,
  }) {
    switch (this) {
      case CurrencyType.pesoArgentino:
        return totalAmountPerMonthPesos(
          financialEntities: financialEntities,
          currency: currency,
        );
      case CurrencyType.usDollar:
        return totalAmountPerMonthDolar(
          financialEntities: financialEntities,
          currency: currency,
        );
      case CurrencyType.euro:
        return totalAmountPerMonthEuro(
          financialEntities: financialEntities,
          currency: currency,
        );
    }
  }

  /// Devuelve la cantidad total de una lista de [FinancialEntity].
  ///
  /// Returns the total amount of a list of [FinancialEntity].
  double totalAmount({
    required List<FinancialEntity> financialEntityList,
    required Currency currency,
  }) {
    switch (this) {
      case CurrencyType.pesoArgentino:
        return totalAmountPesos(
          financialEntityList: financialEntityList,
          currency: currency,
        );
      case CurrencyType.usDollar:
        return totalAmountDolar(
          financialEntityList: financialEntityList,
          currency: currency,
        );
      case CurrencyType.euro:
        return totalAmountEuro(
          financialEntityList: financialEntityList,
          currency: currency,
        );
    }
  }

  /// Devuelve el texto generado para compartir con el usuario.
  ///
  /// Returns the generated text to share with the user.
  String generateText({
    required String financialEntityName,
    required List<Purchase> purchases,
    required double total,
    required Currency currency,
    required CurrencyType selectedCurrency,
  }) {
    return generateText2(
      financialEntityName: financialEntityName,
      purchases: purchases,
      total: total,
      currency: currency,
      selectedCurrency: selectedCurrency,
    );
    // switch (this) {
    //   case CurrencyType.pesoArgentino:
    //     return generateTextPesos(
    //       financialEntityName: financialEntityName,
    //       purchases: purchases,
    //       total: total,
    //       currency: currency,
    //     );
    //   case CurrencyType.usDollar:
    //     return generateTextInDollars(
    //       financialEntityName: financialEntityName,
    //       purchases: purchases,
    //       total: total,
    //       currency: currency,
    //     );
    //   case CurrencyType.euro:
    //     return generateTextInEuros(
    //       financialEntityName: financialEntityName,
    //       purchases: purchases,
    //       total: total,
    //       currency: currency,
    //     );
    // }
  }

  double totalCreditor({
    required List<Purchase> purchases,
    required Currency currency,
  }) {
    final dollarValue = currency.dolarBlue.valueSell;

    final euroValue = currency.euroBlue.valueSell;

    return switch (this) {
      CurrencyType.pesoArgentino => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.usDollar
                  ? purchase.amountPerQuota * dollarValue
                  : purchase.currencyType == CurrencyType.euro
                      ? purchase.amountPerQuota * euroValue
                      : purchase.amountPerQuota),
        ),
      CurrencyType.usDollar => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.usDollar
                  ? purchase.amountPerQuota
                  : purchase.currencyType == CurrencyType.euro
                      ? (purchase.amountPerQuota *
                              currency.euroBlue.valueSell) /
                          dollarValue
                      : purchase.amountPerQuota / dollarValue),
        ),
      CurrencyType.euro => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.euro
                  ? purchase.amountPerQuota
                  : purchase.currencyType == CurrencyType.usDollar
                      ? (purchase.amountPerQuota *
                              currency.dolarBlue.valueSell) /
                          euroValue
                      : purchase.amountPerQuota / euroValue),
        ),
    };
  }

  double totalDebtor({
    required List<Purchase> purchases,
    required Currency currency,
  }) {
    final dollarValue = currency.dolarBlue.valueSell;

    final euroValue = currency.euroBlue.valueSell;

    return switch (this) {
      CurrencyType.pesoArgentino => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.usDollar
                  ? purchase.amountPerQuota * dollarValue
                  : purchase.currencyType == CurrencyType.euro
                      ? purchase.amountPerQuota * euroValue
                      : purchase.amountPerQuota),
        ),
      CurrencyType.usDollar => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.usDollar
                  ? purchase.amountPerQuota
                  : purchase.currencyType == CurrencyType.euro
                      ? (purchase.amountPerQuota *
                              currency.euroBlue.valueSell) /
                          dollarValue
                      : purchase.amountPerQuota / dollarValue),
        ),
      CurrencyType.euro => purchases.fold<double>(
          0,
          (previousValue, purchase) =>
              previousValue +
              (purchase.currencyType == CurrencyType.euro
                  ? purchase.amountPerQuota
                  : purchase.currencyType == CurrencyType.usDollar
                      ? (purchase.amountPerQuota *
                              currency.dolarBlue.valueSell) /
                          euroValue
                      : purchase.amountPerQuota / euroValue),
        ),
    };
  }

  String textoParaCards({
    required Currency currency,
    required Purchase purchase,
  }) {
    final dollarValue = currency.dolarBlue.valueSell;

    final euroValue = currency.euroBlue.valueSell;

    return switch (this) {
      CurrencyType.pesoArgentino => cuotasPesos(
          purchase: purchase,
          dollarValue: dollarValue,
          euroValue: euroValue,
        ),
      CurrencyType.usDollar => cuotasDollars(
          purchase: purchase,
          dollarValue: dollarValue,
          euroValue: euroValue,
        ),
      CurrencyType.euro => cuotasEuros(
          purchase: purchase,
          dollarValue: dollarValue,
          euroValue: euroValue,
        ),
    };
  }

  /// Devuelve `true` si el tipo de moneda es [CurrencyType.pesoArgentino].
  bool get isPesoArgentino => this == CurrencyType.pesoArgentino;

  /// Devuelve `true` si el tipo de moneda es [CurrencyType.usDollar].
  bool get isDolar => this == CurrencyType.usDollar;

  /// Devuelve `true` si el tipo de moneda es [CurrencyType.euro].
  bool get isEuro => this == CurrencyType.euro;
}

String cuotasEuros({
  required Purchase purchase,
  required double dollarValue,
  required double euroValue,
}) {
  if (purchase.currencyType == CurrencyType.pesoArgentino) {
    return '${purchase.name}: ${purchase.amountPerQuota.formatAmount} EUR\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else if (purchase.currencyType == CurrencyType.usDollar) {
    return '${purchase.name}: ${((purchase.amountPerQuota * dollarValue) / euroValue).formatAmount} EUR (${purchase.amountPerQuota} USD)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else {
    return '${purchase.name}: ${(purchase.amountPerQuota / euroValue).formatAmount} EUR (${purchase.amountPerQuota} ARS)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  }
}

String cuotasDollars({
  required Purchase purchase,
  required double dollarValue,
  required double euroValue,
}) {
  if (purchase.currencyType == CurrencyType.usDollar) {
    return '${purchase.name}: ${purchase.amountPerQuota.formatAmount} USD\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else if (purchase.currencyType == CurrencyType.euro) {
    return '${purchase.name}: ${((purchase.amountPerQuota * euroValue) / dollarValue).formatAmount} USD(${purchase.amountPerQuota} EUR)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else {
    return '${purchase.name}: ${(purchase.amountPerQuota / dollarValue).formatAmount} USD(${purchase.amountPerQuota} ARS)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  }
}

String cuotasPesos({
  required Purchase purchase,
  required double dollarValue,
  required double euroValue,
}) {
  if (purchase.currencyType == CurrencyType.usDollar) {
    return '${purchase.name}: ${(purchase.amountPerQuota * dollarValue).formatAmount} ARS (${purchase.amountPerQuota} USD)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else if (purchase.currencyType == CurrencyType.euro) {
    return '${purchase.name}: ${(purchase.amountPerQuota * euroValue).formatAmount} ARS (${purchase.amountPerQuota} EUR)\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  } else {
    return '${purchase.name}: ${purchase.amountPerQuota.formatAmount} ${purchase.currencyType.abreviation}\n'
        'Cuota ${purchase.payedQuotas + 1}/${purchase.numberOfQuotas}\n\n';
  }
}
