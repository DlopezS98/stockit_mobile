import 'package:flutter/material.dart';
import 'package:stockit_mobile/core/constants/view_status.dart';
import 'package:stockit_mobile/services/auth_service.dart';

class RegisterFormProvider extends ChangeNotifier {
  final AuthService _authService;
  RegisterFormProvider(this._authService);

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  ViewStatus _status = ViewStatus.initial;
  ViewStatus get status => _status;

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int roleId,
  }) async {
    _status = ViewStatus.loading;
    notifyListeners();

    try {
      await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        roleId: roleId,
      );
      _status = ViewStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ViewStatus.error;
      notifyListeners();
      return false;
    }
  }
}
