import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/services/firebase_messaging_service.dart';

class UserService {
  static final UserService _instance = UserService._();
  static UserService get instance => _instance;
  UserService._();

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<String> getProfilePicture(String uid) async {
    var value = await firebaseStore.collection('users').doc(uid).get();
    return (value.data() as Map<String, dynamic>)['profilePhoto'];
  }

  Future<AppUser> getAppUser(String uid) async {
    var value = await firebaseStore.collection('users').doc(uid).get();
    return AppUser.fromSnapshot(value);
  }

  Future<void> updateFmToken() async {
    String? fmToken = await FirebaseMessagingService.instance.getFmToken();
    if (fmToken != null) {
      await firebaseStore
          .collection('users')
          .doc(getCurrentUser()!.uid)
          .update({'fmToken': fmToken});
    }
  }

  Future<String?> getFmToken(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await firebaseStore.collection('users').doc(uid).get();
      var snap = snapshot.data() as Map<String, dynamic>;
      return snap['fmToken'];
    } catch (error) {
      return null;
    }
  }
}
