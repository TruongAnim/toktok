import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static const supportedLanguage = [
    Locale('en'),
    Locale('vi'),
  ];
  LanguageController();

  final Rx<Locale> _locale = Rx<Locale>(const Locale('en'));

  Locale get locale => _locale.value;

  void updateLanguage(String language) {
    _locale.value = Locale(language);
    GetStorage().write('language', language);
  }

  void getLanguage() {
    String? language = GetStorage().read('language');
    print('language $language');
    if (language != null) {
      updateLanguage(language);
    } else {
      _locale.value = WidgetsBinding.instance.platformDispatcher.locale;
      print(_locale.value);
    }
  }

  void selectEngLanguage() {
    _locale.value = const Locale('en');
  }

  void selectViLanguage() {
    _locale.value = const Locale('vi');
  }
}
