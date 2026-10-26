import 'package:flutter/material.dart';
import 'package:stockit_mobile/core/errors/app_exception.dart';
import 'package:stockit_mobile/services/auth_service.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  AuthProvider(this._authService);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  AuthStatus _authStatus = AuthStatus.unknown;
  AuthStatus get authStatus => _authStatus;
  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  Future<void> login({required String email, required String password}) async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    notifyListeners();

    try {
      await _authService.login(email, password);
      // await Future.delayed(const Duration(seconds: 3));
      _authStatus = AuthStatus.authenticated;
    } on AppException catch (e) {
      _errorMessage = e.message;
    } on FormatException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
    }

    _isSubmitting = false;
    notifyListeners();
  }

  Future<void> checkSession() async {
    try {
      final bool isAuthenticated = await _authService.isLoggedIn();
      _authStatus = isAuthenticated
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
      _authStatus = AuthStatus.unknown;
    } finally {
      notifyListeners();
    }
  }
}
