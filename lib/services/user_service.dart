import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/data/repositories/user_repository.dart';

class UserService {
 final UserRepository _userRepository;
 const UserService(this._userRepository);

  Future<UserModel> getUserById(int id) async {
    return await _userRepository.getById(id);
  }

  Future<List<UserModel>> searchUsers(Map<String, String>? params) async {
    return await _userRepository.search(params);
  }

  Future<void> updateUser(int id, UserModel data) async {
    await _userRepository.update(id, data);
  }

  Future<void> deleteUser(int id) async {
    await _userRepository.delete(id);
  }

  Future<UserModel> createUser(UserModel data) async {
    return await _userRepository.create(data);
  }
}