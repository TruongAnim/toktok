import 'package:get/get.dart';
import 'package:toktok/BottomNavigation/controllers/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController());
  }
}
