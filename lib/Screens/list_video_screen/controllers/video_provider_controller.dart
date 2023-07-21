import 'package:get/get.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/video_service.dart';

class VideoProviderController extends GetxController {
  RxList<Video> videos = RxList<Video>();

  void updateVideoIds(List<String> videoIds) {
    videos.bindStream(getStreamFromVideoIds(videoIds));
  }

  Stream<List<Video>> getStreamFromVideoIds(List<String> videoIds) {
    return VideoService.instance.getStreamFromVideoIds(videoIds);
  }
}
