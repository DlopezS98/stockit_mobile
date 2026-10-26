import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockit_mobile/core/constants/api_constants.dart';
import 'package:stockit_mobile/core/errors/app_exception.dart';
import 'package:stockit_mobile/data/models/token_model.dart';

typedef AuthTokenProvider = Future<TokenModel?> Function();

class ApiClient {
  final AuthTokenProvider? _authTokenProvider;
  ApiClient({this._authTokenProvider});

  final http.Client _client = http.Client();

  Future<dynamic> get(String path, { Map<String, String>? query }) async => _send('GET', path, query, null);
  Future<dynamic> post(String path, { Object? body }) async => _send('POST', path, null, body);
  Future<dynamic> put(String path, { Object? body }) async => _send('PUT', path, null, body);
  Future<dynamic> delete(String path) async => _send('DELETE', path, null, null);

  Future<dynamic> _send(String method, String path, Map<String, String>? query, Object? body) async {
    final baseUrl = ApiConstants.instance.baseUrl;
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final Map<String, String> headers = {};
    if (body != null) {
      headers['Content-Type'] = 'application/json';
    }

    TokenModel? token = await _authTokenProvider?.call();
    if (token != null && !token.isAccessTokenExpired) {
      headers['Authorization'] = 'Bearer ${token.accessToken}';
    }

    final request = http.Request(method, uri)..headers.addAll(headers);
    if (body != null) {
      request.body = jsonEncode(body);
    }

    final http.Response response;
    try {
      response = await _client.send(request)
        .timeout(ApiConstants.timeoutDuration)
        .then(http.Response.fromStream);
    } on TimeoutException {
      throw const NetworkException('Request timed out. Please try again later.');
    } on http.ClientException {
      throw const NetworkException();
    }

    if (response.statusCode == 401) {
      throw const UnauthorizedException();
    }

    return _decode(response);
  }

  dynamic _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException('Request failed', statusCode: response.statusCode);
    }

    if (response.body.isEmpty) return null;

    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw const ParsingException();
    }
  }

  void dispose() => _client.close();
}