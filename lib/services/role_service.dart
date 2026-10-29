import 'package:stockit_mobile/data/models/role_model.dart';
import 'package:stockit_mobile/data/repositories/role_repository.dart';

class RoleService {
  final RoleRepository _roleRepository;
  const RoleService(this._roleRepository);

  Future<RoleModel> getRoleById(int id) async {
    return await _roleRepository.getById(id);
  }

  Future<List<RoleModel>> getRoles() async {
    return await _roleRepository.getAll();
  }
}
