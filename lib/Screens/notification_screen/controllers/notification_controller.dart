import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/models/video.dart';
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

  Future<String> getUserName(String uid) async {
    return await UserService.instance.getUserName(uid);
  }

  Future<String> getVideoThumnail(String videoId) async {
    return await VideoService.instance.getVideoThumnail(videoId);
  }

  void onTap(int index) async {
    List<Video> videos = await VideoService.instance
        .getVideosFromIds([notifications[index].videoId]);
    Get.toNamed(PageRoutes.followingTabPage, arguments: {
      'videos': videos,
      'isFollowing': false,
      'variable': null,
    });
  }
}
