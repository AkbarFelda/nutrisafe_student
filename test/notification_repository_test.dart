import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nutrisafe_student/features/notifications/data/notification_repository.dart';

void main() {
  test('fetches paginated notifications and parses read state', () async {
    late http.Request captured;
    final repository = NotificationRepository(
      client: MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode({
            'status': 'success',
            'data': [
              {
                'id': 4,
                'title': 'Laporan diterima',
                'message': 'Laporan sedang ditinjau.',
                'read_at': null,
                'created_at': '2026-10-16T08:00:00Z',
              },
            ],
            'total': 1,
            'unread_count': 1,
          }),
          200,
        );
      }),
    );

    final page = await repository.getNotifications('jwt-token');

    expect(captured.url.path, '/notifications');
    expect(captured.url.queryParameters, {'limit': '20', 'offset': '0'});
    expect(captured.headers['Authorization'], 'Bearer jwt-token');
    expect(page.items.single.isRead, isFalse);
    expect(page.unreadCount, 1);
  });

  test('marks one and all notifications read with PATCH', () async {
    final requests = <String>[];
    final repository = NotificationRepository(
      client: MockClient((request) async {
        requests.add('${request.method} ${request.url.path}');
        return http.Response('{}', 200);
      }),
    );

    await repository.markRead('jwt-token', 7);
    await repository.markAllRead('jwt-token');

    expect(requests, [
      'PATCH /notifications/7/read',
      'PATCH /notifications/read-all',
    ]);
  });
}
