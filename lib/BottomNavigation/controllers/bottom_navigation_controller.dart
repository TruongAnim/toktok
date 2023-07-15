import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';

class BottomNavigationController extends GetxController {
  final RxInt _currentIndex = RxInt(0);
  int get getCurrentIndex => _currentIndex.value;

  void changeTab(int index) {
    if (index == 2) {
      Get.toNamed(PageRoutes.addVideo);
    } else {
      _currentIndex.value = index;
    }
  }
}
