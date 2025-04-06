import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/custom_exception.dart';
import 'package:purchase_manager/utilities/models/pm_response.dart';

class AuthRepository {
  final baseUrl = '${Config.apiUrl}/users/';

  Future<PMResponse<int>> login({
    required String? firebaseUserId,
    required String? email,
    required String? name,
  }) async {
    final url = Uri.parse('${baseUrl}login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firebaseUserId': firebaseUserId,
          'email': email,
          'name': name,
        }),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        PMResponse.fromJson(
          jsonData,
          (json) => jsonData['body'] as int,
        ),
        jsonData,
      );

      return result;
    } catch (e, st) {
      handleException(e, st);
    }
  }
}
