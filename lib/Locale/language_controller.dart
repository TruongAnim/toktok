import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  LanguageController();

  final Rx<Locale> _locale = Rx<Locale>(const Locale('en'));

  Locale get locale => _locale.value;

  void selectEngLanguage() {
    _locale.value = const Locale('en');
  }

  void selectArabicLanguage() {
    _locale.value = const Locale('ar');
  }

  void selectPortugueseLanguage() {
    _locale.value = const Locale('pt');
  }

  void selectFrenchLanguage() {
    _locale.value = const Locale('fr');
  }

  void selectIndonesianLanguage() {
    _locale.value = const Locale('id');
  }

  void selectSpanishLanguage() {
    _locale.value = const Locale('es');
  }

  void selectItalianLanguage() {
    _locale.value = const Locale('it');
  }

  void selectTurkishLanguage() {
    _locale.value = const Locale('tr');
  }

  void selectSwahiliLanguage() {
    _locale.value = const Locale('sw');
  }

  void selectGermanLanguage() {
    _locale.value = const Locale('de');
  }

  void selectRomaniaLanguage() {
    _locale.value = const Locale('ro');
  }
}
