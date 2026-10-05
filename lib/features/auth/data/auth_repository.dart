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
      _baseUri = baseUri ?? Uri.parse('https://api.nutrisafe.id/api/');

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

    Map<String, dynamic> json = const {};
    if (response.body.isNotEmpty) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) json = decoded;
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final errors = json['errors'];
      final message =
          json['message']?.toString() ??
          (errors is Map && errors.isNotEmpty
              ? errors.values.first.toString()
              : 'Permintaan gagal (${response.statusCode}).');
      throw ApiException(message, statusCode: response.statusCode);
    }
    return json;
  }
}
