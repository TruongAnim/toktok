import 'package:get/get.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/services/notification_service.dart';
import 'package:toktok/services/user_service.dart';
import 'package:toktok/services/video_service.dart';

class NotificationController extends GetxController {
  NotificationService notiService = NotificationService.instance;
  UserService userService = UserService.instance;
  RxList<Notif> notifications = RxList();
  Future<void> getNotifications() async {
    notifications.value =
        await notiService.getNotifications(userService.getCurrentUser()!.uid);
  }

  Future<String> getUserProfile(String uid) async {
    return await UserService.instance.getProfilePicture(uid);
  }

  Future<String> getVideoThumnail(String videoId) async {
    return await VideoService.instance.getVideoThumnail(videoId);
  }
}
