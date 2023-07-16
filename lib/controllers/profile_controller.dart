import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/video_service.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = ''.obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  void getUserData() async {
    List<Video> videos =
        await VideoService.instance.getVideosFromUser(_uid.value);
    List<Video> favourites =
        await VideoService.instance.getFavouritesFromUser(_uid.value);

    DocumentSnapshot userData =
        await firebaseStore.collection('users').doc(_uid.value).get();
    String userName = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = await VideoService.instance.getLikesOfUser(_uid.value);
    int follower = 0;
    int following = 0;
    bool isFollowing = false;

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
        .doc(AuthController.instance.user.uid)
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
      'favourites': favourites,
      'email': userData['email'],
      'description': userData['description'],
    };
    update();
  }

  followUser() async {
    DocumentSnapshot follower = await firebaseStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(AuthController.instance.user.uid)
        .get();
    if (follower.exists) {
      await firebaseStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(AuthController.instance.user.uid)
          .delete();
      await firebaseStore
          .collection('users')
          .doc(AuthController.instance.user.uid)
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
          .doc(AuthController.instance.user.uid)
          .set({});
      await firebaseStore
          .collection('users')
          .doc(AuthController.instance.user.uid)
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
