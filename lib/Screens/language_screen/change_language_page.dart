import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Locale/language_controller.dart';
import 'package:toktok/Locale/locale.dart';

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
    _selectedLanguage = getCurrentLanguage(_languageController.locale);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _languages = ['English', 'Tiếng Việt'];
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
                  print(value);
                  setState(() {
                    _selectedLanguage = value;
                  });
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
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (_selectedLanguage == 0) {
                    _languageController.selectEngLanguage();
                  } else if (_selectedLanguage == 1) {
                    _languageController.selectViLanguage();
                  }
                  Get.back();
                },
                child: Text(
                  AppLocalizations.of(context)!.done!,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == const Locale('en')) {
      return 0;
    } else if (locale == const Locale('vi')) {
      return 1;
    } else {
      return -1;
    }
  }
}
