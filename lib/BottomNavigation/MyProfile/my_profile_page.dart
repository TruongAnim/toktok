import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/profile_page_button.dart';
import 'package:toktok/Components/row_item.dart';
import 'package:toktok/Components/sliver_app_delegate.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/BottomNavigation/MyProfile/edit_profile.dart';
import 'package:toktok/BottomNavigation/MyProfile/followers.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/BottomNavigation/Explore/explore_page.dart';
import 'package:toktok/BottomNavigation/MyProfile/following.dart';
import 'package:toktok/Components/score_container.dart';
import 'package:toktok/app_config/app_config.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/profile_controller.dart';
import 'package:toktok/models/video.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = firebaseAuth.currentUser!.uid;
    return MyProfileBody(uid: uid);
  }
}

class MyProfileBody extends StatefulWidget {
  const MyProfileBody({super.key, required this.uid});
  final String uid;
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  final key = UniqueKey();
  late ProfileController _profileController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController = Get.find();
    _profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 64.0),
      child: Scaffold(
        backgroundColor: darkColor,
        body: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 404.0,
                        floating: false,
                        actions: <Widget>[
                          Theme(
                            data: Theme.of(context).copyWith(
                              cardColor: backgroundColor,
                            ),
                            child: PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: secondaryColor,
                              ),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none),
                              onSelected: (dynamic value) {
                                if (value == locale!.changeLanguage) {
                                  Navigator.pushNamed(
                                      context, PageRoutes.languagePage);
                                } else if (value == locale.help) {
                                  Navigator.pushNamed(
                                      context, PageRoutes.helpPage);
                                } else if (value == locale.termsOfUse) {
                                  Navigator.pushNamed(
                                      context, PageRoutes.tncPage);
                                } else if (value == locale.logout) {
                                  firebaseAuth.signOut();
                                } else if (value == "Redeem Coins") {
                                  Navigator.pushNamed(
                                      context, PageRoutes.redeemCoins);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    value: locale!.changeLanguage,
                                    textStyle: TextStyle(color: secondaryColor),
                                    child: Text(locale.changeLanguage!),
                                  ),
                                  PopupMenuItem(
                                    value: locale.help,
                                    textStyle: TextStyle(color: secondaryColor),
                                    child: Text(locale.help!),
                                  ),
                                  PopupMenuItem(
                                    value: "Redeem Coins",
                                    textStyle: TextStyle(color: secondaryColor),
                                    child: const Text("Redeem Coins"),
                                  ),
                                  PopupMenuItem(
                                    value: locale.termsOfUse,
                                    textStyle: TextStyle(color: secondaryColor),
                                    child: Text(locale.termsOfUse!),
                                  ),
                                  PopupMenuItem(
                                    value: locale.logout,
                                    textStyle: TextStyle(color: secondaryColor),
                                    child: Text(locale.logout!),
                                  )
                                ];
                              },
                            ),
                          )
                        ],
                        flexibleSpace: Obx(() {
                          if (_profileController.user.isEmpty) {
                            return Container();
                          }
                          return FlexibleSpaceBar(
                            centerTitle: true,
                            title: Column(
                              children: <Widget>[
                                const Spacer(flex: 10),
                                CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage: NetworkImage(
                                      _profileController.user['profilePhoto']),
                                ),
                                const Spacer(),
                                Text(
                                  _profileController.user['name'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '@${_profileController.user['email'].toString().split('@')[0]}',
                                  style: TextStyle(
                                      fontSize: 10, color: disabledTextColor),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageIcon(
                                      const AssetImage(
                                          "assets/icons/ic_fb.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 16),
                                    ImageIcon(
                                      const AssetImage(
                                          "assets/icons/ic_twt.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 16),
                                    ImageIcon(
                                      const AssetImage(
                                          "assets/icons/ic_insta.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  locale!.comment5!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 8),
                                ),
                                const Spacer(),
                                ProfilePageButton(
                                  locale.editProfile,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()));
                                  },
                                  width: 120,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                    RowItem(
                                        _profileController.user['followers'],
                                        locale.followers,
                                        FollowersPage()),
                                    RowItem(
                                        _profileController.user['following'],
                                        locale.following,
                                        FollowingPage()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SliverPersistentHeader(
                        delegate: SliverAppBarDelegate(
                          TabBar(
                            labelColor: mainColor,
                            unselectedLabelColor: lightTextColor,
                            indicatorColor: transparentColor,
                            tabs: const [
                              Tab(icon: Icon(Icons.dashboard)),
                              Tab(icon: Icon(Icons.favorite_border)),
                              Tab(icon: Icon(Icons.bookmark_border)),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: Obx(() {
                    if (_profileController.user.isEmpty) {
                      return Container();
                    }
                    return TabBarView(
                      children: <Widget>[
                        FadedSlideAnimation(
                          beginOffset: const Offset(0, 0.3),
                          endOffset: const Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                          child: TabGrid(
                            _profileController.user['videos'],
                            viewIcon: Icons.remove_red_eye,
                            showView: true,
                            onTap: () => print('video click'),
                          ),
                        ),
                        FadedSlideAnimation(
                          beginOffset: const Offset(0, 0.3),
                          endOffset: const Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                          child: TabGrid(
                            _profileController.user['videos'],
                            icon: Icons.favorite,
                            showView: false,
                          ),
                        ),
                        FadedSlideAnimation(
                          beginOffset: const Offset(0, 0.3),
                          endOffset: const Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                          child: TabGrid(
                            _profileController.user['videos'],
                            icon: Icons.bookmark,
                            showView: false,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const PositionedDirectional(
                top: 40, end: 40, child: CoinContainer()),
          ],
        ),
        // floatingActionButton:  AppConfig.isDemoMode ? BuyThisApp.button(
        //         AppConfig.appName,
        //         'https://dashboard.vtlabs.dev/projects/envato-referral-buy-link?project_slug=qvid_flutter',
        //       ) : null,
        // bottomNavigationBar: AppConfig.isDemoMode ? Container(
        //   padding: const EdgeInsets.all(1.0),
        //   // margin: const EdgeInsets.fromLTRB(10, 0, 0, 60),
        //   child: BuyThisApp.developerRowOpusDark(
        //       Colors.transparent, Theme.of(context).primaryColorLight),
        // )  : const SizedBox.shrink() ,
      ),
    );
  }
}
