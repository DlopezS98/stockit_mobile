import 'package:stockit_mobile/core/constants/regular_expressions.dart';

class UserModel {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final int roleId;
  final String roleName;
  final DateTime createdAt;

  final String _firstName;
  final String _lastName;
  final String _password;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.roleId,
    required this.roleName,
    required this.createdAt,
  }) : _firstName = '',
       _lastName = '',
       _password = '';

  UserModel._createRequest({
    required this.email,
    required this._firstName,
    required this._lastName,
    required this.roleId,
    required this._password,
  }) : fullName = '',
       id = 0,
       username = '',
       roleName = '',
       createdAt = DateTime.now();

  UserModel._updateRequest({
    required this._firstName,
    required this._lastName,
    required this.roleId,
  }) : email = '',
       fullName = '',
       id = 0,
       username = '',
       roleName = '',
       _password = '',
       createdAt = DateTime.now();

  static UserModel fromCreateJson({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int roleId,
  }) {
    final trimmedFirstName = firstName.trim();
    final trimmedLastName = lastName.trim();
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedFirstName.isEmpty ||
        trimmedLastName.isEmpty ||
        trimmedEmail.isEmpty ||
        trimmedPassword.isEmpty) {
      throw const FormatException('All fields are required');
    }

    if (!CommonRegex.emailRegex.hasMatch(trimmedEmail)) {
      throw const FormatException('Invalid email format');
    }

    if (!CommonRegex.passwordRegex.hasMatch(trimmedPassword)) {
      throw const FormatException(
        'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, and a number',
      );
    }

    return UserModel._createRequest(
      email: email.trim(),
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      roleId: roleId,
      password: password.trim()
    );
  }

  static UserModel fromUpdateJson({
    required String firstName,
    required String lastName,
    required int roleId,
  }) {
    return UserModel._updateRequest(
      firstName: firstName,
      lastName: lastName,
      roleId: roleId,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      roleId: json['roleId'] as int,
      roleName: json['roleName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'roleId': roleId,
      'roleName': roleName,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'email': email,
      'firstName': _firstName,
      'lastName': _lastName,
      'roleId': roleId,
      'password': _password,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {'firstName': _firstName, 'lastName': _lastName, 'roleId': roleId};
  }
}
