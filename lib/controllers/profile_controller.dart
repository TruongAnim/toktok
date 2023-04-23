import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/video.dart';

class ProfileController extends GetxController {
  Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = ''.obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  void getUserData() async {
    List<Video> videos = [];
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    videos = snapshot.docs.map((e) => Video.fromSnapshort(e)).toList();
    DocumentSnapshot userData =
        await firebaseStore.collection('users').doc(_uid.value).get();
    String userName = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int follower = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in snapshot.docs) {
      likes += ((item.data()! as dynamic)['likes'] as List).length;
    }
    QuerySnapshot followerDoc = await firebaseStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    QuerySnapshot followingDoc = await firebaseStore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    follower = followerDoc.docs.length;
    following = followingDoc.docs.length;

    DocumentSnapshot follow = await firebaseStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    if (follow.exists) {
      isFollowing = true;
    } else {
      isFollowing = false;
    }
    _user.value = {
      'followers': follower.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': userName,
      'videos': videos,
      'email': userData['email']
    };
    update();
  }

  followUser() async {
    DocumentSnapshot follower = await firebaseStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    if (follower.exists) {
      await firebaseStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firebaseStore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());
    } else {
      await firebaseStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firebaseStore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
