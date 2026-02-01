import 'package:get_x/get.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    // Mock Data
    notifications.value = [
      NotificationModel(
        id: '1',
        title: 'Booking Confirmed',
        description: 'Your session with Emma Wilson is confirmed for Dec 20',
        time: '2 hours ago',
        type: NotificationType.booking,
        isUnread: true,
      ),
      NotificationModel(
        id: '2',
        title: 'New Message',
        description: 'Marco Silva sent you a message',
        time: '5 hours ago',
        type: NotificationType.message,
        isUnread: true,
      ),
      NotificationModel(
        id: '3',
        title: 'Review Reminder',
        description:
            'Don\'t forget to review your session with Tech Media Studio',
        time: '2 days ago',
        type: NotificationType.reminder,
        isUnread: false,
      ),
      NotificationModel(
        id: '4',
        title: 'Payment Successful',
        description: 'Your payment of €1,500 has been processed',
        time: '3 days ago',
        type: NotificationType.payment,
        isUnread: false,
      ),
      NotificationModel(
        id: '5',
        title: 'New Message',
        description: 'SkyView Productions responded to your inquiry',
        time: '5 days ago',
        type: NotificationType.message,
        isUnread: false,
      ),
    ];
    updateUnreadCount();
  }

  void updateUnreadCount() {
    unreadCount.value = notifications.where((n) => n.isUnread).length;
  }

  void markAllAsRead() {
    for (var n in notifications) {
      n.isUnread = false;
    }
    notifications.refresh(); // Force UI update
    updateUnreadCount();
  }

  void removeNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
    updateUnreadCount();
  }
}
