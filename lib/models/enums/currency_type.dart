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
  usDollar;

  /// Crea una instancia de [CurrencyType] a partir de un valor entero.
  ///
  /// Creates an instance of [CurrencyType] from an integer value.
  static CurrencyType type(int value) {
    return switch (value) {
      0 => CurrencyType.pesoArgentino,
      1 => CurrencyType.usDollar,
      _ => throw Exception('Invalid purchase type'),
    };
  }

  /// Devuelve el valor entero del tipo de moneda.
  ///
  /// Returns the integer value of the currency type.
  int get value => switch (this) {
        CurrencyType.pesoArgentino => 0,
        CurrencyType.usDollar => 1,
      };

  /// Devuelve el nombre del tipo de moneda.
  ///
  /// Returns the name of the currency type.
  String get name => switch (this) {
        CurrencyType.pesoArgentino => 'ARS',
        CurrencyType.usDollar => 'USD',
      };
}
