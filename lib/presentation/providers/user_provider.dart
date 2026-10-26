import 'package:flutter/material.dart';
import 'package:stockit_mobile/data/models/user_model.dart';

enum ViewStatus { initial, loading, success, error }

class UserProvider extends ChangeNotifier {
  final List<UserModel> _users = [];
  List<UserModel> get users => _users;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  Future<void> fetchUsers() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));
      _users.addAll([
        UserModel(
          id: 1,
          email: 'john.doe@example.com',
          fullName: 'John Doe',
          createdAt: DateTime.now(),
          roleId: 1,
          roleName: 'Admin',
          username: 'johndoe'
        ),
        UserModel(
          id: 2,
          email: 'jane.smith@example.com',
          fullName: 'Jane Smith',
          createdAt: DateTime.now(),
          roleId: 2,
          roleName: 'User',
          username: 'janesmith'
        ),
        UserModel(
          id: 3,
          email: 'bob.johnson@example.com',
          fullName: 'Bob Johnson',
          createdAt: DateTime.now(),
          roleId: 2,
          roleName: 'User',
          username: 'bobjohnson'
        )
      ]);
      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}