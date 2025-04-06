import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/models/currency.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';

/// {@template DolarService}
/// Servicio que se encarga de obtener el valor del dolar.
/// {@endtemplate}
class DolarService {
  /// Obtiene el valor del dolar.
  /// Gets the value of the dollar.
  Future<Currency> getDollarData() async {
    try {
      const url = 'https://api.bluelytics.com.ar/v2/latest';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        return Currency.fromJson(responseData);
      } else {
        throw CustomException(
          message: 'Failed to load data: ${response.body}',
        );
      }
    } on Exception catch (e) {
      throw CustomException(message: 'Error occurred: $e');
    }
  }
}
