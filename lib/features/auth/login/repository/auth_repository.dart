import 'package:purchase_manager/features/auth/login/dtos/user_dto.dart';
import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

abstract class AuthRepository {
  static final baseUrl = '${Config.apiUrl}/auth/';

  static Future<ResponseLD<UserDto>> login({
    required String? firebaseUserId,
    required String? email,
    required String? name,
  }) async {
    final url = '${baseUrl}login';

    final response = await Repository.post(
      url: url,
      body: {
        'firebaseUserId': firebaseUserId,
        'email': email,
        'name': name,
      },
      fromJson: (jsonData) =>
          UserDto.fromJson(jsonData['body'] as Map<String, dynamic>),
    );

    return response;
  }
}
