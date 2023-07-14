import 'package:flutter/material.dart';
import 'package:toktok/Auth/Login/UI/login_screen.dart';
import 'package:toktok/Auth/Registration/UI/register_screen.dart';
import 'package:toktok/Auth/login_navigator.dart';
import 'package:toktok/Screens/add_video/add_video_page.dart';
import 'package:toktok/Screens/explore/more_page.dart';
import 'package:toktok/Screens/explore/search_users.dart';
import 'package:toktok/Screens/my_profile/badge_request.dart';
import 'package:toktok/Screens/my_profile/language_page.dart';
import 'package:toktok/Screens/my_profile/video_option.dart';
import 'package:toktok/BottomNavigation/bottom_navigation.dart';
import 'package:toktok/Screens/add_video/add_video.dart';
import 'package:toktok/Screens/add_video/add_video_filter.dart';
import 'package:toktok/Screens/my_profile/followers.dart';
import 'package:toktok/Screens/my_profile/help_page.dart';
import 'package:toktok/Screens/add_video/post_info.dart';
import 'package:toktok/Screens/my_profile/tnc.dart';
import 'package:toktok/Screens/my_profile/redeem_coins.dart';
import 'package:toktok/Screens/my_profile/redeem_history.dart';
import 'package:toktok/Screens/chat/chat_page.dart';
import 'package:toktok/Screens/add_music.dart';
import 'package:toktok/Screens/audio.dart';
import 'package:toktok/Screens/user_profile/user_profile.dart';

class PageRoutes {
  static const String loginNavigator = '/login_navigator';
  static const String bottomNavigation = '/bottom_navigation';
  static const String followersPage = '/followers_page';
  static const String helpPage = '/help_page';
  static const String tncPage = '/tnc_page';
  static const String searchPage = '/search_page';
  static const String addVideoPage = '/add_video_page';
  static const String addVideo = '/add_video';
  static const String addVideoFilterPage = '/add_video_filter_page';
  static const String postInfoPage = '/post_info_page';
  static const String userProfilePage = '/user_profile_page';
  static const String chatPage = '/chat_page';
  static const String morePage = '/more_page';
  static const String videoOptionPage = '/video_option_page';
  static const String verifiedBadgePage = '/verified_badge_page';
  static const String languagePage = '/language_page';
  static const String redeemCoins = '/redeemCoins';
  static const String redeemHistory = '/redeemHistory';
  static const String audio = '/audio';
  static const String addMusic = '/addMusic';
  static const String login = '/login';
  static const String register = '/register';

  Map<String, WidgetBuilder> routes() {
    return {
      loginNavigator: (context) => LoginNavigator(),
      bottomNavigation: (context) => BottomNavigation(),
      followersPage: (context) => FollowersPage(),
      helpPage: (context) => HelpPage(),
      tncPage: (context) => TnC(),
      searchPage: (context) => SearchUsers(),
      addVideoPage: (context) => AddVideoPage(),
      addVideo: (context) => AddVideo(),
      addVideoFilterPage: (context) => AddVideoFilter(),
      postInfoPage: (context) => PostInfo(),
      userProfilePage: (context) => UserProfilePage(),
      chatPage: (context) => ChatPage(),
      morePage: (context) => MorePage(title: 'Title', videos: []),
      videoOptionPage: (context) => VideoOptionPage(),
      verifiedBadgePage: (context) => BadgeRequest(),
      languagePage: (context) => ChangeLanguagePage(),
      redeemCoins: (context) => RedeemCoins(),
      redeemHistory: (context) => RedeemHistory(),
      audio: (context) => Audio(),
      addMusic: (context) => AddMusic(),
      login: (context) => MyLogin(),
      register: (context) => MyRegister(),
    };
  }

  Map<String, Widget> widgetRoutes() {
    return {
      loginNavigator: LoginNavigator(),
      bottomNavigation: BottomNavigation(),
      followersPage: FollowersPage(),
      helpPage: HelpPage(),
      tncPage: TnC(),
      searchPage: SearchUsers(),
      addVideoPage: AddVideoPage(),
      addVideo: AddVideo(),
      addVideoFilterPage: AddVideoFilter(),
      postInfoPage: PostInfo(),
      userProfilePage: UserProfilePage(),
      chatPage: ChatPage(),
      morePage: MorePage(title: 'Title', videos: []),
      videoOptionPage: VideoOptionPage(),
      verifiedBadgePage: BadgeRequest(),
      languagePage: ChangeLanguagePage(),
      redeemCoins: RedeemCoins(),
      redeemHistory: RedeemHistory(),
      audio: Audio(),
      addMusic: AddMusic(),
      login: MyLogin(),
      register: MyRegister(),
    };
  }
}
