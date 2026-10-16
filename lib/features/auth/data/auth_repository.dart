import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrisafe_student/features/auth/data/models/auth_models.dart';

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _baseUri = baseUri ?? Uri.parse('https://api.nutrisafe.id/');

  final http.Client _client;
  final Uri _baseUri;

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final json = await _post('login', {'email': email, 'password': password});
    return AuthSession.fromJson(json, fallbackEmail: email);
  }

  Future<Map<String, dynamic>> registerGeneral(
    GeneralRegistration registration,
  ) => _post('register', registration.toJson());

  Future<Map<String, dynamic>> registerSchool(
    SchoolRegistration registration,
  ) => _post('register/school', registration.toJson());

  Future<void> logout(String? token) async {
    await _post('logout', const {}, token: token);
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await _client.post(
      _baseUri.resolve(path),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    final json = _decodeObject(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = _errorMessage(json, response.statusCode);
      throw ApiException(message, statusCode: response.statusCode);
    }
    return json;
  }

  Map<String, dynamic> _decodeObject(String body) {
    if (body.trim().isEmpty) return <String, dynamic>{};
    final decoded = jsonDecode(body);
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }

  String _errorMessage(Map<String, dynamic> json, int statusCode) {
    final errors = json['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final value = errors.values.first;
      if (value is List && value.isNotEmpty) return value.first.toString();
      return value.toString();
    }
    return json['message']?.toString() ?? 'Permintaan gagal ($statusCode).';
  }
}
