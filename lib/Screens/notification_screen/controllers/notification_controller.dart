import 'package:get/get.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/services/notification_service.dart';
import 'package:toktok/services/user_service.dart';

class NotificationController extends GetxController {
  NotificationService notiService = NotificationService.instance;
  UserService userService = UserService.instance;
  RxList<Notif> notifications = RxList();
  void getNotifications() async {
    notifications.value =
        await notiService.getNotifications(userService.getCurrentUser()!.uid);
  }
}
