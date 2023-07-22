import 'package:get/get.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/video_service.dart';

class VideoProviderController extends GetxController {
  final RxList<Video> _videos = RxList<Video>();

  List<Video> get videos => _videos.value;

  void updateVideoIds(List<String> videoIds) {
    _videos.bindStream(getStreamFromVideoIds(videoIds));
  }

  Stream<List<Video>> getStreamFromVideoIds(List<String> videoIds) {
    return VideoService.instance.getStreamFromVideoIds(videoIds);
  }
}
