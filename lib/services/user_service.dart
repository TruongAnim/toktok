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

  Stream<AppUser> getUserStream(String uid) {
    return firebaseStore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => AppUser.fromSnapshot(event));
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

  Future<List<String>> getFollowers(String uid) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .get();
    return snapshot.docs.map((e) => e.id).toList();
  }

  Future<void> movePoints(String currentId, String targetId) async {
    DocumentSnapshot snapshotA = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentId)
        .get();
    DocumentSnapshot snapshotB = await FirebaseFirestore.instance
        .collection('users')
        .doc(targetId)
        .get();

    int pointsA = (snapshotA.data() as Map<String, dynamic>)['points'];
    int pointsB = (snapshotB.data() as Map<String, dynamic>)['points'];

    pointsA -= 5;
    pointsB += 5;

    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.update(snapshotA.reference, {'points': pointsA});
    batch.update(snapshotB.reference, {'points': pointsB});

    await batch.commit();
  }
}
