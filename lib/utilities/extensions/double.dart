import 'package:intl/intl.dart';

/// {@template FormatearDoubleExtension}
/// Extensiones para la clase double
/// Extensions for the double class
/// {@endtemplate}
extension FormatearDoubleExtension on double {
  /// Formatea el monto en formato de moneda
  /// Formats the amount in currency format
  String formatAmount() {
    final formattedNumber = NumberFormat.currency(
      symbol: r'$',
      decimalDigits: 0,
      locale: 'es_ES',
    ).format(this);
    return formattedNumber;
  }
}
