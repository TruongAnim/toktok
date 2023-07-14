import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Screens/my_profile/edit_profile.dart';
import 'package:toktok/Screens/my_profile/followers.dart';
import 'package:toktok/Screens/my_profile/following.dart';
import 'package:toktok/Components/profile_page_button.dart';
import 'package:toktok/Components/row_item.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/profile_controller.dart';

class MyInfo extends StatelessWidget {
  MyInfo({super.key});
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Obx(() {
      if (_profileController.user.isEmpty) {
        return Container();
      }
      return FlexibleSpaceBar(
        centerTitle: true,
        background: Column(
          children: <Widget>[
            const Spacer(),
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(_profileController.user['profilePhoto']),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(flex: 10),
                Text(
                  _profileController.user['name'],
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/ic_verified.png',
                  scale: 4,
                ),
                const Spacer(flex: 8),
              ],
            ),
            Text(
              '@${_profileController.user['email'].toString().split('@')[0]}',
              style: TextStyle(fontSize: 10, color: disabledTextColor),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  const AssetImage("assets/icons/ic_fb.png"),
                  color: secondaryColor,
                  size: 10,
                ),
                const SizedBox(width: 16),
                ImageIcon(
                  const AssetImage("assets/icons/ic_twt.png"),
                  color: secondaryColor,
                  size: 10,
                ),
                const SizedBox(width: 16),
                ImageIcon(
                  const AssetImage("assets/icons/ic_insta.png"),
                  color: secondaryColor,
                  size: 10,
                ),
              ],
            ),
            const Spacer(),
            Text(
              locale!.comment5!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            ProfilePageButton(
              locale.editProfile,
              () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              width: 120,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RowItem(
                    _profileController.user['likes'],
                    locale.liked,
                    Scaffold(
                      appBar: AppBar(
                        title: const Text('Liked'),
                      ),
                      body: TabGrid(
                        _profileController.user['videos'],
                        showView: false,
                      ),
                    )),
                RowItem(_profileController.user['followers'], locale.followers,
                    FollowersPage()),
                RowItem(_profileController.user['following'], locale.following,
                    FollowingPage()),
              ],
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}
