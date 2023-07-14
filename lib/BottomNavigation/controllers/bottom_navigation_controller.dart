import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';

class BottomNavigationController extends GetxController {
  RxInt _currentIndex = RxInt(0);
  int get getCurrentIndex => _currentIndex.value;

  @override
  void onReady() {
    super.onReady();
    Map<String, dynamic>? data = Get.arguments;
    print('onReady');
    if (data != null) {
      print(data);
      if (data['tab'] == 'notification') {
        changeTab(3);
      }
    }
  }

  void changeTab(int index) {
    if (index == 2) {
      Get.toNamed(PageRoutes.addVideo);
    } else {
      _currentIndex.value = index;
    }
  }
}
