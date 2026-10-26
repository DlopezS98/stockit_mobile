import 'package:flutter/material.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/services/user_service.dart';

enum ViewStatus { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final UserService _userService;
  UserProvider(this._userService);


  Future<void> fetchUsers() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      _users = await _userService.searchUsers(null);
      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}