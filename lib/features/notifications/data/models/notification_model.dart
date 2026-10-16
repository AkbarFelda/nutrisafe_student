class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    this.type,
  });

  final int id;
  final String title;
  final String message;
  final DateTime? createdAt;
  final bool isRead;
  final String? type;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final readAt = json['read_at'];
    return NotificationModel(
      id: int.tryParse('${json['id'] ?? 0}') ?? 0,
      title: '${json['title'] ?? json['subject'] ?? 'Notifikasi'}',
      message: '${json['message'] ?? json['body'] ?? json['content'] ?? ''}',
      createdAt: DateTime.tryParse(
        '${json['created_at'] ?? json['createdAt'] ?? ''}',
      ),
      isRead: readAt != null || json['is_read'] == true || json['read'] == true,
      type: json['type']?.toString(),
    );
  }

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    id: id,
    title: title,
    message: message,
    createdAt: createdAt,
    isRead: isRead ?? this.isRead,
    type: type,
  );
}
