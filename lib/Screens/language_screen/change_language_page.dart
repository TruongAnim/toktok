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
    final List<String> _languages = ['English', 'Tiếng Việt'];
    _selectedLanguage = getCurrentLanguage(_languageController.locale);
    return Obx(
      () {
        print('udpate lang' + _languageController.locale.languageCode);
        print(AppLocalizations.of(context)!.locale);
        print(Localizations.localeOf(context).toString());
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
                        _languageController.selectViLanguage();
                      }
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
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )),
              ],
            ),
          ),
        );
      },
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
