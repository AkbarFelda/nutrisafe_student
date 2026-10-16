import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nutrisafe_student/features/school/data/models/school_models.dart';
import 'package:nutrisafe_student/features/school/data/school_repository.dart';

void main() {
  test(
    'school repository implements every documented school operation',
    () async {
      final requests = <String>[];
      final repository = SchoolRepository(
        client: MockClient((request) async {
          requests.add('${request.method} ${request.url.path}');
          final path = request.url.path;
          if (path.endsWith('/allergy-data') && request.method == 'GET') {
            return http.Response(jsonEncode({'data': <dynamic>[]}), 200);
          }
          if (path.endsWith('/students') && request.method == 'GET') {
            return http.Response(jsonEncode({'data': <dynamic>[]}), 200);
          }
          if (path.endsWith('/profile')) {
            return http.Response(
              jsonEncode({
                'data': {
                  'id': 28,
                  'name': 'SDN Tangerang 15',
                  'email': 'sdn.tangerang.15@sch.id',
                },
              }),
              200,
            );
          }
          if (request.method == 'DELETE') return http.Response('{}', 200);
          return http.Response(jsonEncode({'data': <String, dynamic>{}}), 200);
        }),
      );
      const token = 'school-token';
      const allergy = SchoolAllergyModel(
        studentName: 'Vina',
        className: '6A',
        allergyType: 'Alergi Kacang',
        description: 'Gatal-gatal',
        severity: 'Ringan',
        actionRequired: 'Pisahkan menu',
      );
      const student = SchoolStudentModel(
        id: 7,
        name: 'Vina',
        nisn: '0051234567',
        className: 'VI A',
        gender: 'Perempuan',
        address: 'Jl. Merdeka No. 1',
      );

      await repository.getProfile(token);
      await repository.updateProfile(token, {'lokasi': 'Jalan Baru'});
      await repository.createAllergy(token, allergy);
      await repository.getAllergies(token);
      await repository.getAllergyMenu(token);
      await repository.getSppgInfo(token);
      await repository.createStudent(token, student);
      await repository.getStudents(token);
      await repository.updateStudent(token, student);
      await repository.deleteStudent(token, student.id);

      expect(requests, [
        'GET /school/profile',
        'PUT /school/profile',
        'POST /school/allergy-data',
        'GET /school/allergy-data',
        'GET /school/allergy-menu',
        'GET /school/sppg-info',
        'POST /school/students',
        'GET /school/students',
        'PUT /school/students/7',
        'DELETE /school/students/7',
      ]);
    },
  );
}
