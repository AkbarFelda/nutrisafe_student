import 'package:get/get.dart';
import 'package:nutrisafe_student/features/notifications/data/models/notification_model.dart';
import 'package:nutrisafe_student/features/notifications/data/notification_repository.dart';

class NotificationController extends GetxController {
  NotificationController(this._repository);

  final NotificationRepository _repository;
  final items = <NotificationModel>[].obs;
  final unreadCount = 0.obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<void> load(String token) async {
    if (token.isEmpty || isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final page = await _repository.getNotifications(token);
      items.assignAll(page.items);
      unreadCount.value = page.unreadCount;
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markRead(String token, int id) async {
    final index = items.indexWhere((item) => item.id == id);
    if (index < 0 || items[index].isRead) return;
    await _repository.markRead(token, id);
    items[index] = items[index].copyWith(isRead: true);
    if (unreadCount.value > 0) unreadCount.value--;
  }

  Future<void> markAllRead(String token) async {
    await _repository.markAllRead(token);
    items.assignAll(items.map((item) => item.copyWith(isRead: true)));
    unreadCount.value = 0;
  }
}
