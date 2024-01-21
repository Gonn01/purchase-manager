import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:purchase_manager/models/coin.dart';

class DolarService {
  final Dio _dio = Dio();

  Future<Coin?> getCoinData() async {
    try {
      var url = 'https://dolarapi.com/v1/dolares/blue';

      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        if (response.data != null) {
          log("Response data: ${response.data}");

          // Assuming Coin.fromJson handles a Map<String, dynamic>
          return Coin.fromJson(response.data);
        } else {
          log("Empty response body");
        }
      } else {
        log("Request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error occurred: $e");
    }
    return null;
  }
}
