import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/utilities/models/currency.dart';

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
          final responseData = response.data!;

          return Currency.fromJson(responseData);
        } else {
          debugPrint('Empty response body');
        }
      } else {
        debugPrint('Request failed with status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      debugPrint('Error occurred: $e');
    }
    return null;
  }
}
