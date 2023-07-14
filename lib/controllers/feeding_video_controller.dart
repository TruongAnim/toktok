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
    super.onInit();
    String uid = firebaseAuth.currentUser!.uid;
    _videoList.bindStream(
      firebaseStore.collection('videos').snapshots().map(
        (QuerySnapshot snapshot) {
          return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
        },
      ),
    );
    QuerySnapshot followingDoc = await firebaseStore
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();
    List<String> userFollowing = followingDoc.docs
        .map((QueryDocumentSnapshot snapshot) => snapshot.id)
        .toList();

    _videoFollowing.bindStream(
      firebaseStore
          .collection('videos')
          .where('uid', whereIn: userFollowing)
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
        },
      ),
    );
  }
}
