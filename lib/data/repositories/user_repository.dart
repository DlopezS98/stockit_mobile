import 'package:stockit_mobile/core/constants/api_constants.dart';
import 'package:stockit_mobile/core/errors/app_exception.dart';
import 'package:stockit_mobile/core/network/api_client.dart';
import 'package:stockit_mobile/data/models/user_model.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<UserModel> getById(int id) async {
    final json = await _apiClient.get('${ApiConstants.users}/$id');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return UserModel.fromJson(json);
  }

  Future<List<UserModel>> search(Map<String, String>? params) async {
    final data = await _apiClient.get(ApiConstants.users, query: params);
    if (data is! List) throw ParsingException();

    return data.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}