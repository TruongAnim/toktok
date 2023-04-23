import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/BottomNavigation/Home/following_tab.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/feeding_video_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late FeedingVideoController _feedingVideoController;

  @override
  void initState() {
    super.initState();
    // _checkForBuyNow();
    _feedingVideoController = Get.find();
  }

  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(text: AppLocalizations.of(context)!.news),
      Tab(text: AppLocalizations.of(context)!.following),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Stack(
        children: <Widget>[
          TabBarView(
            children: <Widget>[
              Obx(() {
                return FollowingTabPage(
                    _feedingVideoController.videoList, false);
              }),
              Obx(() {
                return FollowingTabPage(
                    _feedingVideoController.videoList, true);
              }),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    indicator: BoxDecoration(color: transparentColor),
                    tabs: tabs,
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: 14,
                    start: 160,
                    child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _checkForBuyNow() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (!sharedPreferences.containsKey("key_buy_this_shown") &&
  //       AppConfig.isDemoMode) {
  //     Future.delayed(Duration(seconds: 20), () async {
  //       if (mounted) {
  //         BuyThisApp.showSubscribeDialog(context);
  //         sharedPreferences.setBool("key_buy_this_shown", true);
  //       }
  //     });
  //   }
  // }
}
