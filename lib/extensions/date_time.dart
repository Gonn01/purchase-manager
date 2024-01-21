import 'package:intl/intl.dart';

/// {@template DateTimeX}
/// Extensiones para la clase DateTime
/// Extensions for the DateTime class
/// {@endtemplate}
extension DateTimeX on DateTime {
  /// Formatea la fecha en formato dd/MM/yyyy
  /// Formats the date in dd/MM/yyyy format
  String get format => DateFormat('dd/MM/yyyy').format(this);
}
