import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Screens/my_profile/followers.dart';
import 'package:toktok/Screens/my_profile/following.dart';
import 'package:toktok/Components/profile_page_button.dart';
import 'package:toktok/Components/row_item.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/profile_controller.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GetBuilder<ProfileController>(
        builder: (ProfileController _profileController) {
      if (_profileController.user.isEmpty) {
        return Container();
      }
      return FlexibleSpaceBar(
        centerTitle: true,
        background: Column(
          children: <Widget>[
            const Spacer(),
            FadedScaleAnimation(
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage(_profileController.user['profilePhoto']),
              ),
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
            FadedScaleAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageIcon(
                    const AssetImage(
                      "assets/icons/ic_fb.png",
                    ),
                    color: secondaryColor,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ImageIcon(
                    const AssetImage("assets/icons/ic_twt.png"),
                    color: secondaryColor,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ImageIcon(
                    const AssetImage("assets/icons/ic_insta.png"),
                    color: secondaryColor,
                    size: 10,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              locale!.comment7!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ProfilePageButton(locale.message,
                    () => Navigator.pushNamed(context, PageRoutes.chatPage)),
                const SizedBox(width: 16),
                _profileController.user['isFollowing']
                    ? ProfilePageButton(locale.following, () {
                        _profileController.followUser();
                      })
                    : ProfilePageButton(
                        locale.follow,
                        () {
                          _profileController.followUser();
                        },
                        color: mainColor,
                        textColor: secondaryColor,
                      ),
              ],
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
