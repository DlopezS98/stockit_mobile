import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  String get baseUrl => dotenv.env['BASE_API_URL'] ?? '';
  String get environment => dotenv.env['ENVIRONMENT'] ?? '';

  ApiConstants._privateConstructor();
  static final ApiConstants _instance = ApiConstants._privateConstructor();
  static ApiConstants get instance => _instance;

  static const String users = '/users';
  static const String products = '/products';
  static const String roles = '/roles';
  static const String login = '/auth/login';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';

  static const Duration timeoutDuration = Duration(seconds: 30);

}