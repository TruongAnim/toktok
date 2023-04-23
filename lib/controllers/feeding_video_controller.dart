import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/video.dart';

class FeedingVideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  final Rx<List<Video>> _videoFollowing = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;
  List<Video> get videoFollowing => _videoFollowing.value;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    String uid = firebaseAuth.currentUser!.uid;
    _videoList.bindStream(firebaseStore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((e) => Video.fromSnapshort(e)).toList();
    }));
    QuerySnapshot followingDoc = await firebaseStore
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();
    List<String> userFollowing = followingDoc.docs
        .map((QueryDocumentSnapshot snapshot) => snapshot.id)
        .toList();
    print(userFollowing);

    _videoFollowing.bindStream(firebaseStore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((e) => Video.fromSnapshort(e)).toList();
    }));
  }

  void like(String videoId) async {
    DocumentSnapshot doc =
        await firebaseStore.collection('videos').doc(videoId).get();
    var currentUid = authController.user.uid;
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
