import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/school/data/models/school_models.dart';

class SchoolRepository {
  SchoolRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _baseUri = baseUri ?? Uri.parse('https://api.nutrisafe.id/api/');

  final http.Client _client;
  final Uri _baseUri;

  Future<SchoolProfileModel> getProfile(String token) async {
    final json = await _request('GET', 'school/profile', token: token);
    return SchoolProfileModel.fromJson(_dataMap(json));
  }

  Future<SchoolProfileModel> updateProfile(
    String token,
    Map<String, dynamic> changes,
  ) async {
    final json = await _request(
      'PUT',
      'school/profile',
      token: token,
      body: changes,
    );
    return SchoolProfileModel.fromJson(_dataMap(json));
  }

  Future<List<SchoolAllergyModel>> getAllergies(String token) async {
    final json = await _request('GET', 'school/allergy-data', token: token);
    return _dataList(json).map(SchoolAllergyModel.fromJson).toList();
  }

  Future<SchoolAllergyModel> createAllergy(
    String token,
    SchoolAllergyModel allergy,
  ) async {
    final json = await _request(
      'POST',
      'school/allergy-data',
      token: token,
      body: allergy.toJson(),
    );
    return SchoolAllergyModel.fromJson(_dataMap(json));
  }

  Future<Map<String, dynamic>> getAllergyMenu(String token) =>
      _request('GET', 'school/allergy-menu', token: token);

  Future<Map<String, dynamic>> getSppgInfo(String token) =>
      _request('GET', 'school/sppg-info', token: token);

  Future<List<SchoolStudentModel>> getStudents(String token) async {
    final json = await _request('GET', 'school/students', token: token);
    return _dataList(json).map(SchoolStudentModel.fromJson).toList();
  }

  Future<SchoolStudentModel> createStudent(
    String token,
    SchoolStudentModel student,
  ) async {
    final json = await _request(
      'POST',
      'school/students',
      token: token,
      body: student.toJson(),
    );
    return SchoolStudentModel.fromJson(_dataMap(json));
  }

  Future<SchoolStudentModel> updateStudent(
    String token,
    SchoolStudentModel student,
  ) async {
    final json = await _request(
      'PUT',
      'school/students/${student.id}',
      token: token,
      body: student.toJson(),
    );
    return SchoolStudentModel.fromJson(_dataMap(json));
  }

  Future<void> deleteStudent(String token, int id) async {
    await _request('DELETE', 'school/students/$id', token: token);
  }

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    required String token,
    Map<String, dynamic>? body,
  }) async {
    final request = http.Request(method, _baseUri.resolve(path))
      ..headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
    if (body != null) request.body = jsonEncode(body);
    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);
    final decoded = response.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(response.body);
    final json = decoded is Map<String, dynamic>
        ? decoded
        : <String, dynamic>{};
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        json['message']?.toString() ??
            'Permintaan gagal (${response.statusCode}).',
        statusCode: response.statusCode,
      );
    }
    return json;
  }

  Map<String, dynamic> _dataMap(Map<String, dynamic> json) =>
      json['data'] is Map<String, dynamic>
      ? json['data'] as Map<String, dynamic>
      : json;

  List<Map<String, dynamic>> _dataList(Map<String, dynamic> json) =>
      (json['data'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .toList();
}
