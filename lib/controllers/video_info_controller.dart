import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';

class VideoInfoController extends GetxController {
  void like(String videoId) async {
    DocumentSnapshot doc =
        await firebaseStore.collection('videos').doc(videoId).get();
    var currentUid = AuthController.instance.user.uid;
    if (((doc.data()! as dynamic)['likes'] as List).contains(currentUid)) {
      await firebaseStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayRemove([currentUid])
      });
    } else {
      await firebaseStore.collection('videos').doc(videoId).update({
        'likes': FieldValue.arrayUnion([currentUid])
      });
    }
  }
}
