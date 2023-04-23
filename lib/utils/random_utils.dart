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
}
