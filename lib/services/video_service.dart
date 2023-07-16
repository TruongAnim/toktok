import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/video.dart';

class VideoService {
  static final VideoService _instance = VideoService._();
  static VideoService get instance => _instance;
  VideoService._();

  Future<String> getVideoThumnail(String videoId) async {
    var value = await firebaseStore.collection('videos').doc(videoId).get();
    return (value.data() as Map<String, dynamic>)['thumbnail'];
  }

  Future<List<Video>> getVideos(List<String> videoId) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('id', whereIn: videoId)
        .get();
    return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
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
}
