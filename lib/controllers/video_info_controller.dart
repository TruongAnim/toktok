import 'package:get/get.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/firebase_messaging_service.dart';
import 'package:toktok/services/video_service.dart';

class VideoInfoController extends GetxController {
  void like(Video video) async {
    String currentUid = AuthController.instance.user.uid;
    VideoService.instance.like(currentUid, video);
    createFavouriteNotification(video);
  }

  void createFavouriteNotification(Video video) async {
    AppUser appUser = AuthController.instance.appUser.value;
    Notif notif = Notif(
        id: '',
        uid: video.uid,
        senderId: AuthController.instance.user.uid,
        isRead: false,
        title: '${appUser.name} liked your video.',
        desc: '',
        type: 'favourite',
        videoId: video.id,
        time: DateTime.now().millisecondsSinceEpoch);
    FirebaseMessagingService.instance.sendNotification(notif);
  }

  void increaseView(String videoId) {
    VideoService.instance.increseView(videoId);
  }

  void donate(Video video) {
    AppUser currentUser = AuthController.instance.appUser.value;
    if (currentUser.points >= 5 && video.uid != currentUser.uid) {
      VideoService.instance.donate(video, currentUser);
    }
  }
}
