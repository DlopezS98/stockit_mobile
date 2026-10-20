import 'package:stockit_mobile/core/constants/regular_expressions.dart';
import 'package:stockit_mobile/data/models/token_model.dart';
// import 'package:stockit_mobile/data/models/token_model.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/data/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;
  // final TokenService _tokenService;

  // AuthService(this._authRepository, this._tokenService);
  AuthService(this._authRepository);

  Future<void> login(String email, String password) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw const FormatException('Email and password cannot be empty');
    }

    if (!CommonRegex.emailRegex.hasMatch(trimmedEmail)) {
      throw const FormatException('Invalid email format');
    }

    if (!CommonRegex.passwordRegex.hasMatch(trimmedPassword)) {
      throw const FormatException(
        'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, and a number',
      );
    }

    final TokenModel token = await _authRepository.login(email, password);
  }

  Future<UserModel> getCurrentUser() async {
    return await _authRepository.currentUser();
  }

  // Future<void> logout() async {
  //   // Implement logout logic here, e.g., clear tokens, user data, etc.
  // }
}
