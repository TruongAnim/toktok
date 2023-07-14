import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Screens/explore/explore_page.dart';
import 'package:toktok/Screens/home_screen/home_page.dart';
import 'package:toktok/Screens/my_profile/my_profile_page.dart';
import 'package:toktok/BottomNavigation/controllers/bottom_navigation_controller.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/Theme/style.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final BottomNavigationController _bottomNavigationController = Get.find();
  final List<Widget> _children = [
    HomePage(),
    ExplorePage(),
    Container(),
    Container(),
    MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_home.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_homeactive.png')),
        label: locale.home,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_explore.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_exploreactive.png')),
        label: locale.explore,
      ),
      BottomNavigationBarItem(
        icon: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              borderRadius: radius,
              color: mainColor,
            ),
            child: Icon(Icons.add)),
        label: ' ',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_notification.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/icons/ic_notificationactive.png')),
        label: locale.notification,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_profile.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_profileactive.png')),
        label: locale.profile,
      ),
    ];
    return Scaffold(
      body: Obx(
        () => Stack(
          children: <Widget>[
            _children[_bottomNavigationController.getCurrentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                currentIndex: _bottomNavigationController.getCurrentIndex,
                backgroundColor: transparentColor,
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                iconSize: 22.0,
                selectedItemColor: secondaryColor,
                selectedFontSize: 12,
                unselectedFontSize: 10,
                unselectedItemColor: secondaryColor,
                items: _bottomBarItems,
                onTap: (value) {
                  _bottomNavigationController.changeTab(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
