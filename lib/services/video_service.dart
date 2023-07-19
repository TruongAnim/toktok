import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/user_service.dart';

class VideoService {
  static final VideoService _instance = VideoService._();
  static VideoService get instance => _instance;
  VideoService._();

  Future<String> getVideoThumnail(String videoId) async {
    var value = await firebaseStore.collection('videos').doc(videoId).get();
    return (value.data() as Map<String, dynamic>)['thumbnail'];
  }

  Future<List<Video>> getVideosFromIds(List<String> videoId) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('id', whereIn: videoId)
        .get();
    return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
  }

  Future<List<Video>> getVideosFromUser(String uid) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('uid', isEqualTo: uid)
        .get();
    return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
  }

  Future<List<Video>> getFavouritesFromUser(String uid) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('likes', arrayContains: uid)
        .get();
    return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
  }

  Future<int> getLikesOfUser(String uid) async {
    try {
      QuerySnapshot snapshot = await firebaseStore
          .collection('videos')
          .where('uid', isEqualTo: uid)
          .get();
      int likes = 0;
      for (var item in snapshot.docs) {
        likes += ((item.data()! as dynamic)['likes'] as List).length;
      }
      return likes;
    } catch (error) {
      return 0;
    }
  }

  void increseView(String videoId) {
    final DocumentReference documentRef =
        FirebaseFirestore.instance.collection('videos').doc(videoId);

    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        final DocumentSnapshot snapshot = await transaction.get(documentRef);
        if (snapshot.exists) {
          final currentValue = snapshot.get('viewCount') ?? 0;
          transaction.update(documentRef, {'viewCount': currentValue + 1});
        }
      },
    );
  }

  void donate(Video video, AppUser currentUser) async {
    FirebaseFirestore.instance
        .collection('videos')
        .doc(video.id)
        .update({'points': video.points + 5});
    UserService.instance.movePoints(currentUser.uid, video.uid);
  }

  void like(String uid, Video video) async {
    if (video.likes.contains(uid)) {
      await firebaseStore.collection('videos').doc(video.id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseStore.collection('videos').doc(video.id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
