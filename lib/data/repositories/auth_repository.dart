import 'package:stockit_mobile/core/constants/api_constants.dart';
import 'package:stockit_mobile/core/errors/app_exception.dart';
import 'package:stockit_mobile/core/network/api_client.dart';
import 'package:stockit_mobile/data/models/token_model.dart';
import 'package:stockit_mobile/data/models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<TokenModel> login(String email, String password) async {
    final json = await _apiClient.post(
      ApiConstants.login,
      body: {'email': email, 'password': password},
    );
    
    if (json is! Map<String, dynamic>) throw ParsingException();

    return TokenModel.fromJson(json);
  }

  Future<UserModel> currentUser() async {
    final json = await _apiClient.get(ApiConstants.me);
    if (json == null) throw const UnauthorizedException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return UserModel.fromJson(json);
  }
}
