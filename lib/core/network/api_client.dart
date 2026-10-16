import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockit_mobile/core/constants/api_constants.dart';

class ApiClient {
  final http.Client _client = http.Client();

  Future<dynamic> get(String path, { Map<String, String>? query }) async => _send('GET', path, query, null);
  Future<dynamic> post(String path, { Object? body }) async => _send('POST', path, null, body);
  Future<dynamic> put(String path, { Object? body }) async => _send('PUT', path, null, body);
  Future<dynamic> delete(String path) async => _send('DELETE', path, null, null);

  Future<dynamic> _send(String method, String path, Map<String, String>? query, Object? body) async {
    final baseUrl = ApiConstants.instance.baseUrl;
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final headers = {'Content-Type': 'application/json'};
    if (body != null) {
      headers['Content-Type'] = 'application/json';
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
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }

    return response;
  }
}