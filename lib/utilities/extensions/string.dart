/// {@template StringX}
/// Extensiones para la clase String
/// Extensions for the String class
/// {@endtemplate}
extension StringX on String {
  /// Capitaliza la primera letra de la cadena
  /// Capitalizes the first letter of the string
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
