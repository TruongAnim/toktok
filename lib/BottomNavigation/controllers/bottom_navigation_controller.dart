import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';

class BottomNavigationController extends GetxController {
  RxInt _currentIndex = RxInt(0);
  int get getCurrentIndex => _currentIndex.value;

  void onTap(int index, BuildContext context) {
    if (index == 2) {
      Navigator.pushNamed(context, PageRoutes.addVideo);
    } else {
      _currentIndex.value = index;
    }
  }
}
