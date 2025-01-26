/// {@template Currency}
/// Modelo de datos de la moneda
/// Data model of the currency
/// {@endtemplate}
class Currency {
  ///{@macro Currency}
  Currency({
    required this.dolarOficial,
    required this.dolarBlue,
    required this.euroOficial,
    required this.euroBlue,
    required this.lastUpdate,
  });

  /// Crea una instancia de [Currency] vacía
  ///
  /// Creates an instance of [Currency] empty
  const Currency.empty()
      : dolarOficial =
            const CurrencyValue(valueAverage: 0, valueSell: 0, valueBuy: 0),
        dolarBlue =
            const CurrencyValue(valueAverage: 0, valueSell: 0, valueBuy: 0),
        euroOficial =
            const CurrencyValue(valueAverage: 0, valueSell: 0, valueBuy: 0),
        euroBlue =
            const CurrencyValue(valueAverage: 0, valueSell: 0, valueBuy: 0),
        lastUpdate = '';

  /// Crea una instancia de [Currency] a partir de un mapa
  ///
  /// Creates an instance of [Currency] from a map
  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        dolarOficial:
            CurrencyValue.fromJson(json['oficial'] as Map<String, dynamic>),
        dolarBlue: CurrencyValue.fromJson(json['blue'] as Map<String, dynamic>),
        euroOficial: CurrencyValue.fromJson(
          json['oficial_euro'] as Map<String, dynamic>,
        ),
        euroBlue:
            CurrencyValue.fromJson(json['blue_euro'] as Map<String, dynamic>),
        lastUpdate: json['last_update'] as String,
      );

  /// Valor de compra de la moneda
  /// Purchase value of the currency
  final CurrencyValue dolarOficial;

  /// Valor de venta de la moneda
  /// Sale value of the currency
  final CurrencyValue dolarBlue;

  /// Casa de cambio
  /// Exchange house
  final CurrencyValue euroOficial;

  /// Nombre de la moneda
  /// Name of the currency
  final CurrencyValue euroBlue;

  /// Tipo de moneda
  /// Type of currency
  final String lastUpdate;

  /// Convierte una instancia de [Currency] a un mapa
  ///
  /// Converts an instance of [Currency] to a map
  Map<String, dynamic> toJson() => {
        'oficial': dolarOficial.toJson(),
        'blue': dolarBlue.toJson(),
        'oficial_euro': euroOficial.toJson(),
        'blue_euro': euroBlue.toJson(),
        'moneda': lastUpdate,
      };
}

/// {@template CurrencyValue}
/// Modelo de datos del valor de la moneda
///
/// Data model of the currency value
/// {@endtemplate}
class CurrencyValue {
  ///{@macro CurrencyValue}
  const CurrencyValue({
    required this.valueAverage,
    required this.valueSell,
    required this.valueBuy,
  });

  /// Crea una instancia de [CurrencyValue] a partir de un mapa
  ///
  /// Creates an instance of [CurrencyValue] from a map
  factory CurrencyValue.fromJson(Map<String, dynamic> json) => CurrencyValue(
        valueAverage: json['value_avg'] as double,
        valueSell: json['value_sell'] as double,
        valueBuy: json['value_buy'] as double,
      );

  /// Valor promedio
  ///
  /// Average value
  final double valueAverage;

  /// Valor de venta
  ///
  /// Sale value
  final double valueSell;

  /// Valor de compra
  ///
  /// Purchase value
  final double valueBuy;

  /// Convierte una instancia de [CurrencyValue] a un mapa
  ///
  /// Converts an instance of [CurrencyValue] to a map
  Map<String, dynamic> toJson() => {
        'value_avg': valueAverage,
        'value_sell': valueSell,
        'value_buy': valueBuy,
      };
}
