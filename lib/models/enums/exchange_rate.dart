enum Currency {
  pesoArgentino,
  usDollar;

  static Currency type(int value) {
    return switch (value) {
      0 => Currency.pesoArgentino,
      1 => Currency.usDollar,
      _ => throw Exception('Invalid purchase type'),
    };
  }

  int get value => switch (this) {
        Currency.pesoArgentino => 0,
        Currency.usDollar => 1,
      };
  String get name => switch (this) {
        Currency.pesoArgentino => 'ARS',
        Currency.usDollar => 'USD',
      };
}
