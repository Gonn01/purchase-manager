import 'package:purchase_manager/utilities/constants/config.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/repository.dart';

class AuthRepository {
  final baseUrl = '${Config.apiUrl}/users/';

  Future<ResponseLD<int>> login({
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
      fromJson: (jsonData) => jsonData['body'] as int,
    );

    return response;
  }
}
