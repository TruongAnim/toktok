import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toktok/BottomNavigation/MyProfile/language_page.dart';
import 'package:toktok/Locale/language_controller.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/style.dart';

void main() async {
  Get.lazyPut(() => LanguageController(), fenix: true);
  runApp(
    const GetMaterialApp(
      home: Toktok(),
    ),
  );
  MobileAds.instance.initialize();
}

class Toktok extends StatelessWidget {
  const Toktok({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageController languageController = Get.find();
    return Obx(
      () => MaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('id'),
          Locale('fr'),
          Locale('pt'),
          Locale('es'),
          Locale('it'),
          Locale('sw'),
          Locale('tr'),
          Locale('de'),
          Locale('ro'),
        ],
        theme: appTheme,
        locale: languageController.locale,
        home: ChangeLanguagePage(),
        routes: PageRoutes().routes(),
      ),
    );
  }
}
