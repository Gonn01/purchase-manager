import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:purchase_manager/models/currency.dart';

/// {@template DolarService}
/// Servicio que se encarga de obtener el valor del dolar.
/// {@endtemplate}
class DolarService {
  final Dio _dio = Dio();

  /// Obtiene el valor del dolar.
  /// Gets the value of the dollar.
  Future<Currency?> getDollarData() async {
    try {
      const url = 'https://dolarapi.com/v1/dolares/blue';

      final response = await _dio.get<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        if (response.data != null) {
          log('Response data: ${response.data}');

          // Explicitly cast response.data to Map<String, dynamic>
          final responseData = response.data!;

          return Currency.fromJson(responseData);
        } else {
          log('Empty response body');
        }
      } else {
        log('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }
    return null;
  }
}
