import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/hashtag.dart';
import 'package:toktok/models/video.dart';

class HashtagController extends GetxController {
  final Rx<List<Hashtag>> _hashtags = Rx<List<Hashtag>>([]);

  List<Hashtag> get hashtags => _hashtags.value;

  void getHashtags() async {
    print('mylog getHashtags');
    QuerySnapshot querySnapshot =
        await firebaseStore.collection('hashtags').get();
    List<Map<String, dynamic>> listHashtag = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    List<Hashtag> result = [];
    for (var item in listHashtag) {
      if (item.isEmpty) {
        continue;
      }
      List<Video> videos = await getVideo(item['videos']);
      result.add(Hashtag(name: item['name'], videos: videos));
    }
    _hashtags.value = result;
    print('mylog ${hashtags[0].videos}');
  }

  Future<List<Video>> getVideo(List<dynamic> videoId) async {
    QuerySnapshot snapshot = await firebaseStore
        .collection('videos')
        .where('id', whereIn: videoId)
        .get();
    return snapshot.docs.map((e) => Video.fromSnapshot(e)).toList();
  }
}
