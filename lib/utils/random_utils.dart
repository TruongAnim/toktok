import 'dart:math';

class RandomUtils {
  static String getRandomImageUrl() {
    Random random = Random();
    int randomId = random.nextInt(70);
    return 'https://i.pravatar.cc/150?img=$randomId';
  }
}
