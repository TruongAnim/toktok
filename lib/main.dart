import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toktok/Locale/language_controller.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/style.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/controllers/comment_controller.dart';
import 'package:toktok/controllers/music_controller.dart';
import 'package:toktok/controllers/profile_controller.dart';
import 'package:toktok/controllers/search_user_controller.dart';
import 'package:toktok/controllers/upload_controller.dart';
import 'package:toktok/controllers/feeding_video_controller.dart';
import 'package:toktok/controllers/video_info_controller.dart';
import 'package:toktok/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.lazyPut(() => LanguageController(), fenix: true);
    Get.lazyPut(() => UploadController(), fenix: true);
    Get.lazyPut(() => FeedingVideoController(), fenix: true);
    Get.lazyPut(() => CommentController(), fenix: true);
    Get.lazyPut(() => SearchUserController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MusicController(), fenix: true);
    Get.lazyPut(() => VideoInfoController(), fenix: true);
    Get.put(AuthController());
  });

  MobileAds.instance.initialize();
  await GetStorage.init();
  runApp(const Toktok());
}

class Toktok extends StatelessWidget {
  const Toktok({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? language = box.read('language_selected');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
      locale: Locale(language ?? 'en'),
      initialRoute:
          language == null ? PageRoutes.languagePage : PageRoutes.login,
      getPages: [
        ...PageRoutes().widgetRoutes().entries.map(
              (entry) => GetPage(name: entry.key, page: () => entry.value),
            ),
      ],
    );
  }
}
