import 'package:intl/intl.dart';

extension FormatearDoubleExtension on double {
  String formatAmount() {
    String formattedNumber = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
      locale: 'es_ES',
    ).format(this);
    return formattedNumber;
  }

  String formatearMonto2() {
    String formattedNumber = NumberFormat.currency(
      decimalDigits: 0,
    ).format(this);
    return formattedNumber;
  }
}
