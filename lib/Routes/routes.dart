import 'package:flutter/material.dart';
import 'package:toktok/Auth/Login/UI/login_screen.dart';
import 'package:toktok/Auth/Registration/UI/register_screen.dart';
import 'package:toktok/Auth/login_navigator.dart';
import 'package:toktok/BottomNavigation/Explore/more_page.dart';
import 'package:toktok/BottomNavigation/MyProfile/badge_request.dart';
import 'package:toktok/BottomNavigation/MyProfile/language_page.dart';
import 'package:toktok/BottomNavigation/MyProfile/video_option.dart';
import 'package:toktok/BottomNavigation/bottom_navigation.dart';
import 'package:toktok/BottomNavigation/AddVideo/add_video.dart';
import 'package:toktok/BottomNavigation/AddVideo/add_video_filter.dart';
import 'package:toktok/BottomNavigation/MyProfile/followers.dart';
import 'package:toktok/BottomNavigation/MyProfile/help_page.dart';
import 'package:toktok/BottomNavigation/AddVideo/post_info.dart';
import 'package:toktok/BottomNavigation/Explore/search_users.dart';
import 'package:toktok/BottomNavigation/MyProfile/tnc.dart';
import 'package:toktok/BottomNavigation/MyProfile/redeem_coins.dart';
import 'package:toktok/BottomNavigation/MyProfile/redeem_history.dart';
import 'package:toktok/Chat/chat_page.dart';
import 'package:toktok/Screens/add_music.dart';
import 'package:toktok/Screens/audio.dart';
import 'package:toktok/Screens/user_profile.dart';

class PageRoutes {
  static const String loginNavigator = '/login_navigator';
  static const String bottomNavigation = '/bottom_navigation';
  static const String followersPage = '/followers_page';
  static const String helpPage = '/help_page';
  static const String tncPage = '/tnc_page';
  static const String searchPage = '/search_page';
  static const String addVideoPage = '/add_video_page';
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
      addVideoPage: (context) => AddVideo(),
      addVideoFilterPage: (context) => AddVideoFilter(),
      postInfoPage: (context) => PostInfo(),
      userProfilePage: (context) => UserProfilePage(),
      chatPage: (context) => ChatPage(),
      morePage: (context) => MorePage(),
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
      addVideoPage: AddVideo(),
      addVideoFilterPage: AddVideoFilter(),
      postInfoPage: PostInfo(),
      userProfilePage: UserProfilePage(),
      chatPage: ChatPage(),
      morePage: MorePage(),
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
