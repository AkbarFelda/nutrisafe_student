import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/auth/data/models/auth_models.dart';

void main() {
  test('email domain resolves student before school suffix', () {
    expect(roleFromEmail('andi@siswa.sch.id'), 'siswa');
    expect(roleFromEmail('sdn.tangerang.15@sch.id'), 'sekolah');
    expect(roleFromEmail('siti@gmail.com'), 'umum');
  });

  test('login posts credentials and parses wrapped session', () async {
    late http.Request captured;
    final repository = AuthRepository(
      client: MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode({
            'data': {
              'access_token': 'token-123',
              'user': {'email': 'murid@siswa.sch.id'},
            },
          }),
          200,
        );
      }),
    );

    final session = await repository.login(
      email: 'murid@siswa.sch.id',
      password: 'password123',
    );

    expect(captured.url.toString(), 'https://api.nutrisafe.id/login');
    expect(jsonDecode(captured.body), {
      'email': 'murid@siswa.sch.id',
      'password': 'password123',
    });
    expect(session.token, 'token-123');
    expect(session.user.role, 'siswa');
  });

  test(
    'school registration uses school endpoint and complete payload',
    () async {
      late http.Request captured;
      final repository = AuthRepository(
        client: MockClient((request) async {
          captured = request;
          return http.Response('{}', 201);
        }),
      );

      await repository.registerSchool(
        const SchoolRegistration(
          name: 'Vina',
          email: 'oranyecats@gmail.com',
          phone: '081234567890',
          schoolName: 'SDN Tangerang 15',
          npsn: '123419293',
          address: 'Jl. Merdeka No. 1',
          grade: 'SD/MI',
        ),
      );

      expect(
        captured.url.toString(),
        'https://api.nutrisafe.id/register/school',
      );
      expect(jsonDecode(captured.body), {
        'name': 'Vina',
        'email': 'oranyecats@gmail.com',
        'phone': '081234567890',
        'school_name': 'SDN Tangerang 15',
        'npsn': '123419293',
        'address': 'Jl. Merdeka No. 1',
        'grade': 'SD/MI',
      });
    },
  );

  test('logout sends bearer token to shared logout endpoint', () async {
    late http.Request captured;
    final repository = AuthRepository(
      client: MockClient((request) async {
        captured = request;
        return http.Response('{}', 200);
      }),
    );

    await repository.logout('token-123');

    expect(captured.url.toString(), 'https://api.nutrisafe.id/logout');
    expect(captured.headers['Authorization'], 'Bearer token-123');
  });

  test('login parses the production top-level role and token', () async {
    final repository = AuthRepository(
      client: MockClient(
        (_) async => http.Response(
          jsonEncode({
            'status': 'success',
            'message': 'Login berhasil',
            'role': 'siswa',
            'token': 'production-token',
          }),
          200,
        ),
      ),
    );

    final session = await repository.login(
      email: 'murid@siswa.sch.id',
      password: 'password123',
    );

    expect(session.token, 'production-token');
    expect(session.user.role, 'siswa');
  });
}
