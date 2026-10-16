import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/school/data/models/school_models.dart';

class SchoolRepository {
  SchoolRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _baseUri = baseUri ?? Uri.parse('https://api.nutrisafe.id/');

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

  Future<List<SchoolClassModel>> getClasses(String token) async {
    final json = await _request('GET', 'school/classes', token: token);
    return _dataList(json).map(SchoolClassModel.fromJson).toList();
  }

  Future<SchoolClassModel> createClass(String token, String name) async {
    final json = await _request(
      'POST',
      'school/classes',
      token: token,
      body: {'name': name},
    );
    return SchoolClassModel.fromJson(_dataMap(json));
  }

  Future<void> deleteClass(String token, int id) =>
      _request('DELETE', 'school/classes/$id', token: token);

  Future<List<SchoolTeacherModel>> getTeachers(String token) async {
    final json = await _request('GET', 'school/teachers', token: token);
    return _dataList(json).map(SchoolTeacherModel.fromJson).toList();
  }

  Future<SchoolTeacherModel> createTeacher(
    String token,
    SchoolTeacherModel teacher,
  ) async {
    final json = await _request(
      'POST',
      'school/teachers',
      token: token,
      body: teacher.toJson(),
    );
    return SchoolTeacherModel.fromJson(_dataMap(json));
  }

  Future<SchoolTeacherModel> updateTeacher(
    String token,
    SchoolTeacherModel teacher,
  ) async {
    final json = await _request(
      'PUT',
      'school/teachers/${teacher.id}',
      token: token,
      body: teacher.toJson(),
    );
    return SchoolTeacherModel.fromJson(_dataMap(json));
  }

  Future<void> deleteTeacher(String token, int id) =>
      _request('DELETE', 'school/teachers/$id', token: token);

  Future<List<Map<String, dynamic>>> getReports(String token) async =>
      _dataList(await _request('GET', 'school/reports', token: token));

  Future<Map<String, dynamic>> getReport(String token, int id) async =>
      _dataMap(await _request('GET', 'school/reports/$id', token: token));

  Future<Map<String, dynamic>> getPendingDelivery(String token) =>
      _request('GET', 'school/pending-delivery', token: token);

  Future<Map<String, dynamic>> createReport(
    String token, {
    required String issueType,
    required String description,
    required DateTime reportDate,
    Uint8List? photoBytes,
    String photoName = 'report.jpg',
  }) => _multipart(
    'school/reports',
    token: token,
    fields: {
      'issue_type': issueType,
      'description': description,
      'report_date': _dateOnly(reportDate),
    },
    photoBytes: photoBytes,
    photoName: photoName,
  );

  Future<Map<String, dynamic>> confirmDelivery(
    String token, {
    required int deliveryId,
    required int receivedPortions,
    Uint8List? photoBytes,
    String photoName = 'receipt.jpg',
  }) => _multipart(
    'school/delivery-receipt',
    token: token,
    fields: {
      'delivery_id': '$deliveryId',
      'received_portions': '$receivedPortions',
    },
    photoBytes: photoBytes,
    photoName: photoName,
  );

  Future<List<Map<String, dynamic>>> bulkCreateStudents(
    String token,
    List<SchoolStudentModel> students,
  ) async => _dataList(
    await _request(
      'POST',
      'school/students/bulk',
      token: token,
      body: {'students': students.map((item) => item.toJson()).toList()},
    ),
  );

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
    final decoded = response.body.trim().isEmpty
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

  Future<Map<String, dynamic>> _multipart(
    String path, {
    required String token,
    required Map<String, String> fields,
    Uint8List? photoBytes,
    required String photoName,
  }) async {
    final request = http.MultipartRequest('POST', _baseUri.resolve(path))
      ..headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      })
      ..fields.addAll(fields);
    if (photoBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes('photo', photoBytes, filename: photoName),
      );
    }
    final response = await http.Response.fromStream(
      await _client.send(request),
    );
    final decoded = response.body.trim().isEmpty
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

  String _dateOnly(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  Map<String, dynamic> _dataMap(Map<String, dynamic> json) =>
      json['data'] is Map<String, dynamic>
      ? json['data'] as Map<String, dynamic>
      : json;

  List<Map<String, dynamic>> _dataList(Map<String, dynamic> json) =>
      ((json['data'] is List ? json['data'] : const <dynamic>[])
              as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList();
}
