import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/firebase_messaging_service.dart';
import 'package:toktok/services/video_service.dart';

class VideoInfoController extends GetxController {
  void like(String videoId) async {
    DocumentSnapshot doc =
        await firebaseStore.collection('videos').doc(videoId).get();
    Video video = Video.fromSnapshot(doc);
    String currentUid = AuthController.instance.user.uid;
    if (video.likes.contains(currentUid)) {
      await firebaseStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayRemove([currentUid])
      });
    } else {
      await firebaseStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayUnion([currentUid])
      });
      createFavouriteNotification(video);
    }
  }

  void createFavouriteNotification(Video video) async {
    AppUser appUser = AuthController.instance.appUser;
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
}
