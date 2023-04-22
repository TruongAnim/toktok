import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toktok/Locale/language_controller.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageController _languageController;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _languages = [
      'English',
      'عربى',
      'français',
      'bahasa Indonesia',
      'português',
      'Español',
      'italiano',
      'Türk',
      'Kiswahili',
      'Deutsch',
      'Română'
    ];
    _selectedLanguage = getCurrentLanguage(_languageController.locale);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.changeLanguage!),
      ),
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 150),
              itemCount: _languages.length,
              itemBuilder: (context, index) => RadioListTile(
                onChanged: (dynamic value) async {
                  setState(() {
                    _selectedLanguage = value;
                    // Navigator.pushNamed(
                    //     context, PageRoutes.bottomNavigation);
                  });
                  if (_selectedLanguage == 0) {
                    _languageController.selectEngLanguage();
                  } else if (_selectedLanguage == 1) {
                    _languageController.selectArabicLanguage();
                  } else if (_selectedLanguage == 2) {
                    _languageController.selectFrenchLanguage();
                  } else if (_selectedLanguage == 3) {
                    _languageController.selectIndonesianLanguage();
                  } else if (_selectedLanguage == 4) {
                    _languageController.selectPortugueseLanguage();
                  } else if (_selectedLanguage == 5) {
                    _languageController.selectSpanishLanguage();
                  } else if (_selectedLanguage == 6) {
                    _languageController.selectItalianLanguage();
                  } else if (_selectedLanguage == 7) {
                    _languageController.selectTurkishLanguage();
                  } else if (_selectedLanguage == 8) {
                    _languageController.selectSwahiliLanguage();
                  } else if (_selectedLanguage == 9) {
                    _languageController.selectGermanLanguage();
                  } else if (_selectedLanguage == 10) {
                    _languageController.selectRomaniaLanguage();
                  }
                  Get.updateLocale(_languageController.locale);
                },
                groupValue: _selectedLanguage,
                value: index,
                title: Text(_languages[index]),
              ),
            ),
            PositionedDirectional(
                bottom: 20,
                start: 20,
                end: 20,
                child: TextButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    final box = GetStorage();
                    box.write('language_selected',
                        _languageController.locale.toString());
                    Get.offAllNamed(PageRoutes.login);
                  },
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.button,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == const Locale('en'))
      return 0;
    else if (locale == const Locale('ar'))
      return 1;
    else if (locale == const Locale('fr'))
      return 2;
    else if (locale == const Locale('id'))
      return 3;
    else if (locale == const Locale('pt'))
      return 4;
    else if (locale == const Locale('es'))
      return 5;
    else if (locale == const Locale('it'))
      return 6;
    else if (locale == const Locale('tr'))
      return 7;
    else if (locale == const Locale('sw'))
      return 8;
    else if (locale == const Locale('de'))
      return 9;
    else if (locale == const Locale('ro'))
      return 10;
    else
      return -1;
  }
}
