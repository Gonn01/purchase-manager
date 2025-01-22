import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/models/currency.dart';

/// {@template DolarService}
/// Servicio que se encarga de obtener el valor del dolar.
/// {@endtemplate}
class DolarService {
  /// Obtiene el valor del dolar.
  /// Gets the value of the dollar.
  Future<Currency?> getDollarData() async {
    try {
      const url = 'https://dolarapi.com/v1/dolares/blue';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body) as Map<String, dynamic>?;

        if (responseData != null) {
          return Currency.fromJson(responseData);
        } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
