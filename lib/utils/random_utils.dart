import 'dart:math';
import 'package:numeral/numeral.dart';

class RandomUtils {
  static String getRandomImageUrl() {
    Random random = Random();
    int randomId = random.nextInt(70);
    return 'https://i.pravatar.cc/150?img=$randomId';
  }

  static String getRandomView() {
    Random random = Random();
    int randomView = random.nextInt(1000000000);
    return Numeral(randomView).format(fractionDigits: 1);
  }

  static String getRandomVideo() {
    List<String> videos = [
      'assets/videos/1.mp4',
      'assets/videos/2.mp4',
      'assets/videos/3.mp4',
      'assets/videos/4.mp4',
      'assets/videos/5.mp4',
      'assets/videos/6.mp4',
    ];
    Random random = Random();
    return videos[random.nextInt(videos.length)];
  }
}
