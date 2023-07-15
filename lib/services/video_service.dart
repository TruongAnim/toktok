import 'package:toktok/constants.dart';

class VideoService {
  static final VideoService _instance = VideoService._();
  static VideoService get instance => _instance;
  VideoService._();

  Future<String> getVideoThumnail(String videoId) async {
    var value = await firebaseStore.collection('videos').doc(videoId).get();
    return (value.data() as Map<String, dynamic>)['thumbnail'];
  }
}
