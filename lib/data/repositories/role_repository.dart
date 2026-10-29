import 'package:stockit_mobile/core/constants/api_constants.dart';
import 'package:stockit_mobile/core/errors/app_exception.dart';
import 'package:stockit_mobile/core/network/api_client.dart';
import 'package:stockit_mobile/data/models/role_model.dart';

class RoleRepository {
  final ApiClient _apiClient;

  RoleRepository(this._apiClient);

  Future<RoleModel> getById(int id) async {
    final json = await _apiClient.get('${ApiConstants.roles}/$id');
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw ParsingException();

    return RoleModel.fromJson(json);
  }

  Future<List<RoleModel>> getAll() async {
    final data = await _apiClient.get(ApiConstants.roles);
    if (data is! List) throw ParsingException();

    return data.map((json) => RoleModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
