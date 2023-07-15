import 'package:get/get.dart';
import 'package:toktok/Screens/notification_screen/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
