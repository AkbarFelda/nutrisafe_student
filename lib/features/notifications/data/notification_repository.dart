import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/notifications/data/models/notification_model.dart';

class NotificationPage {
  const NotificationPage({
    required this.items,
    required this.total,
    required this.unreadCount,
  });

  final List<NotificationModel> items;
  final int total;
  final int unreadCount;
}

class NotificationRepository {
  NotificationRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _baseUri = baseUri ?? Uri.parse('https://api.nutrisafe.id/');

  final http.Client _client;
  final Uri _baseUri;

  Future<NotificationPage> getNotifications(
    String token, {
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    final uri = _baseUri
        .resolve('notifications')
        .replace(
          queryParameters: {
            'limit': '$limit',
            'offset': '$offset',
            if (unreadOnly) 'unread_only': 'true',
          },
        );
    final json = await _request('GET', uri, token);
    final data = json['data'];
    final list = data is List ? data : const <dynamic>[];
    return NotificationPage(
      items: list
          .whereType<Map<String, dynamic>>()
          .map(NotificationModel.fromJson)
          .toList(),
      total: int.tryParse('${json['total'] ?? list.length}') ?? list.length,
      unreadCount: int.tryParse('${json['unread_count'] ?? 0}') ?? 0,
    );
  }

  Future<int> getUnreadCount(String token) async {
    final json = await _request(
      'GET',
      _baseUri.resolve('notifications/unread-count'),
      token,
    );
    return int.tryParse('${json['unread_count'] ?? 0}') ?? 0;
  }

  Future<void> markRead(String token, int id) =>
      _request('PATCH', _baseUri.resolve('notifications/$id/read'), token);

  Future<void> markAllRead(String token) =>
      _request('PATCH', _baseUri.resolve('notifications/read-all'), token);

  Future<Map<String, dynamic>> _request(
    String method,
    Uri uri,
    String token,
  ) async {
    final request = http.Request(method, uri)
      ..headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
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
}
