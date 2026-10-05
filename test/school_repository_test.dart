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
        email: 'vina@siswa.sch.id',
        phone: '081234567890',
        schoolName: 'SDN Tangerang 15',
        npsn: '123419293',
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
        'GET /api/school/profile',
        'PUT /api/school/profile',
        'POST /api/school/allergy-data',
        'GET /api/school/allergy-data',
        'GET /api/school/allergy-menu',
        'GET /api/school/sppg-info',
        'POST /api/school/students',
        'GET /api/school/students',
        'PUT /api/school/students/7',
        'DELETE /api/school/students/7',
      ]);
    },
  );
}
