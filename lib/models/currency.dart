/// {@template Coin}
/// Modelo de datos de la moneda
/// Data model of the currency
/// {@endtemplate}
class Currency {
  ///{@macro Coin}
  Currency({
    required this.compra,
    required this.venta,
    required this.casa,
    required this.nombre,
    required this.moneda,
    required this.fechaActualizacion,
  });

  /// Crea una instancia de [Currency] a partir de un mapa
  ///
  /// Creates an instance of [Currency] from a map
  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        compra: json['compra'] as int,
        venta: json['venta'] as int,
        casa: json['casa'] as String,
        nombre: json['nombre'] as String,
        moneda: json['moneda'] as String,
        fechaActualizacion:
            DateTime.parse(json['fechaActualizacion'] as String),
      );

  /// Valor de compra de la moneda
  /// Purchase value of the currency
  int compra;

  /// Valor de venta de la moneda
  /// Sale value of the currency
  int venta;

  /// Casa de cambio
  /// Exchange house
  String casa;

  /// Nombre de la moneda
  /// Name of the currency
  String nombre;

  /// Tipo de moneda
  /// Type of currency
  String moneda;

  /// Fecha de actualización
  /// Update date
  DateTime fechaActualizacion;

  /// Convierte una instancia de [Currency] a un mapa
  ///
  /// Converts an instance of [Currency] to a map
  Map<String, dynamic> toJson() => {
        'compra': compra,
        'venta': venta,
        'casa': casa,
        'nombre': nombre,
        'moneda': moneda,
        'fechaActualizacion': fechaActualizacion.toIso8601String(),
      };
}
